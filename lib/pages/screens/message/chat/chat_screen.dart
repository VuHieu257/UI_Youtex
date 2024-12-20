import 'dart:convert';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:ui_youtex/core/size/size.dart';
import 'package:ui_youtex/core/themes/theme_extensions.dart';

import '../../../widget_small/showdialog/showdialog.dart';
import '../../../../core/assets.dart';
import '../../../widget_small/chat/chat_bubble.dart';
import '../group_chat_settings/group_chat_settings.dart';

class ChatScreen extends StatefulWidget {
  final String chatId;
  final String name;
  final String currentUserId;
  final String receiverId;
  final String receiverName;

  const ChatScreen({
    super.key,
    required this.chatId,
    required this.name,
    required this.receiverId,
    required this.currentUserId,
    required this.receiverName,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool showEmojis = false;
  bool _isRecording = false;
  bool showImg = false;

  final TextEditingController _messageController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  Set<String> selectedMessages = {};
  bool isSelecting = false;
  double _currentHeight = 0.35;
  List<AssetEntity> images = [];
  List<Uint8List?> thumbnails = [];
  List<bool> selectedImages = [];
  List<String> uploadedUrls = [];

  FlutterSoundRecorder? _recorder;
  String? _audioPath;
  String? _currentPlayingUrl;

  final AudioPlayer audioPlayer = AudioPlayer();
  bool isPlaying = false;

  Future<void> playAudio(String url) async {
    if (isPlaying && _currentPlayingUrl == url) {
      await audioPlayer.stop();
      setState(() {
        isPlaying = false;
        _currentPlayingUrl = null;
      });
    } else {
      await audioPlayer.stop();
      await audioPlayer.play(UrlSource(url));
      setState(() {
        isPlaying = true;
        _currentPlayingUrl = url;
      });
    }
  }

  Future<void> _startRecording() async {
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      return;
    }

    _recorder ??= FlutterSoundRecorder();
    await _recorder!.openRecorder();
    await _recorder!.startRecorder(toFile: 'audio.aac');
    setState(() {
      _isRecording = true;
    });
  }

  Future<void> _stopRecordingAndSendMessage() async {
    if (_recorder == null) return;

    final path = await _recorder!.stopRecorder();
    await _recorder!.closeRecorder();
    setState(() {
      _isRecording = false;
    });
    if (path != null) {
      _audioPath = path;
      _sendMessage();
    }
  }

  Future<void> loadImages() async {
     var status = await Permission.photos.status;

    if (status.isDenied) {
       status = await Permission.photos.request();
    }

    if (status.isPermanentlyDenied) {
       
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Quyền truy cập ảnh"),
            content: Text(
                "Ứng dụng cần quyền truy cập ảnh. Vui lòng cấp quyền trong cài đặt."),
            actions: [
              TextButton(
                onPressed: () async {
                  Navigator.of(context).pop();
                  await openAppSettings();
                },
                child: Text("Đi đến cài đặt"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Hủy"),
              ),
            ],
          );
        },
      );
      return;
    } else if (status.isGranted) {
      // Quyền được cấp, tiếp tục tải ảnh
      final albums =
          await PhotoManager.getAssetPathList(type: RequestType.image);
      final recentAlbum = albums.first;
      final recentImages =
          await recentAlbum.getAssetListRange(start: 0, end: 100);

      List<Uint8List?> thumbnailDataList = await Future.wait(
        recentImages.map((image) => image.thumbnailData).toList(),
      );

      setState(() {
        images = recentImages;
        thumbnails = thumbnailDataList;
        selectedImages = List<bool>.filled(images.length, false);
      });
    }
  }

  void onImageTap(int index) {
    setState(() {
      selectedImages[index] = !selectedImages[index]; // Đổi trạng thái chọn
    });
  }

  Future<String?> uploadImage(Uint8List imageData, String imageName) async {
    try {
      if (imageData.isEmpty) {
        if (kDebugMode) {
          print("Image data is empty for image: $imageName");
        }
        return null;
      }

      final storageRef =
          FirebaseStorage.instance.ref().child("uploads/$imageName");
      final uploadTask = storageRef.putData(imageData);

      final snapshot = await uploadTask.whenComplete(() {
        if (kDebugMode) {
          print("Upload complete for: $imageName");
        }
      });

      final downloadUrl = await snapshot.ref.getDownloadURL();
      if (kDebugMode) {
        print("Download URL for $imageName: $downloadUrl");
      }
      return downloadUrl;
    } catch (e) {
      if (kDebugMode) {
        print("Error uploading image: $e");
      }
      return null;
    }
  }

  Future<void> uploadSelectedImages() async {
    List<Uint8List> selectedImageData = [];
    for (int i = 0; i < images.length; i++) {
      if (selectedImages[i] && thumbnails[i] != null) {
        selectedImageData.add(thumbnails[i]!);
      }
    }

    List<String> urls = [];
    for (int i = 0; i < selectedImageData.length; i++) {
      String? url = await uploadImage(selectedImageData[i], "image_$i.jpg");
      if (url != null) {
        urls.add(url);
      }
    }

    setState(() {
      uploadedUrls = urls;
    });
  }

  // Future<String?> _uploadAudio() async {
  //   if (_audioPath == null) return null;
  //   try {
  //     String fileName =
  //         '${widget.currentUserId}_${DateTime.now().millisecondsSinceEpoch}_audio.aac';
  //     final audioRef =
  //         FirebaseStorage.instance.ref().child('chat_audio/$fileName');
  //     UploadTask uploadTask = audioRef.putFile(File(_audioPath!));
  //     TaskSnapshot snapshot = await uploadTask;
  //     return await snapshot.ref.getDownloadURL();
  //   } catch (e) {
  //     print('Error uploading audio: $e');
  //     return null;
  //   }
  // }
  Future<String?> _uploadAudio() async {
    if (_audioPath == null) return null;

    try {
      // Đọc file âm thanh dưới dạng byte
      File audioFile = File(_audioPath!);
      Uint8List audioBytes = await audioFile.readAsBytes();

      // Chuyển byte thành base64 string
      String base64Audio = base64Encode(audioBytes);

      // Tạo dữ liệu để lưu vào Firebase
      Map<String, dynamic> audioData = {
        "senderId": widget.currentUserId,
        "type": "audio",
        "content": base64Audio,
        "timestamp": DateTime.now().millisecondsSinceEpoch,
      };

      DatabaseReference messageRef =
          FirebaseDatabase.instance.ref('voice/${widget.chatId}').push();
      await messageRef.set(audioData);

      return messageRef.key;
    } catch (e) {
      if (kDebugMode) {
        print('Error uploading audio: $e');
      }
      return null;
    }
  }

  final ImagePicker _picker = ImagePicker();

  // void _sendMessage() async {
  //   String message = _messageController.text.trim();
  //   _messageController.clear();
  //
  //   if (message.isEmpty && _selectedImages.isEmpty && _audioPath == null) {
  //     return;
  //   }
  //
  //   String currentUserId = widget.currentUserId;
  //   var messageRef = _fireStore
  //       .collection('chats')
  //       .doc(widget.chatId)
  //       .collection('messages')
  //       .doc();
  //
  //   List<String> imageUrls = [];
  //
  //   for (XFile image in _selectedImages) {
  //     try {
  //       String fileName =
  //           '${currentUserId}_${DateTime.now().millisecondsSinceEpoch}';
  //       UploadTask uploadTask = FirebaseStorage.instance
  //           .ref()
  //           .child('chat_images/$fileName')
  //           .putFile(File(image.path));
  //
  //       TaskSnapshot snapshot = await uploadTask;
  //       String downloadUrl = await snapshot.ref.getDownloadURL();
  //       imageUrls.add(downloadUrl);
  //     } catch (e) {
  //       print('Error uploading image: $e');
  //     }
  //   }
  //
  //   String? audioUrl = await _uploadAudio();
  //
  //   await messageRef.set({
  //     'senderId': currentUserId,
  //     'receiverId': widget.receiverId,
  //     'message': message,
  //     'imageUrls': imageUrls,
  //     'audioUrl': audioUrl??"",
  //     'timestamp': FieldValue.serverTimestamp(),
  //   });
  //
  //   await _fireStore.collection('chats').doc(widget.chatId).update({
  //     'lastMessage': message.isNotEmpty
  //         ? message
  //         : (audioUrl != null ? 'Đã gửi tin nhắn thoại' : 'Đã gửi ảnh'),
  //     'lastTimestamp': FieldValue.serverTimestamp(),
  //   });
  //
  //   setState(() {
  //     _selectedImages = [];
  //     _audioPath = null;
  //   });
  // }
  void _sendMessage() async {
    String message = _messageController.text.trim();
    _messageController.clear();

    if (message.isEmpty && _selectedImages.isEmpty && _audioPath == null) {
      return;
    }

    String currentUserId = widget.currentUserId;
    var messageRef = _fireStore
        .collection('chats')
        .doc(widget.chatId)
        .collection('messages')
        .doc();

    List<String> imageUrls = [];

    for (XFile image in _selectedImages) {
      try {
        File imageFile = File(image.path);
        List<int> imageBytes = await imageFile.readAsBytes();
        String base64Image = base64Encode(imageBytes);

        String imageId =
            '${messageRef.id}_image_${DateTime.now().millisecondsSinceEpoch}';
        DatabaseReference imageRef =
            FirebaseDatabase.instance.ref().child('chat_images/$imageId');

        await imageRef.set({
          'base64': base64Image,
          'fileName': image.name,
          'senderId': currentUserId,
          'timestamp': ServerValue.timestamp,
        });

        imageUrls.add(imageId);
      } catch (e) {
        if (kDebugMode) {
          print('Error uploading image: $e');
        }
      }
    }

    String? audioUrl = await _uploadAudio();

    await messageRef.set({
      'senderId': currentUserId,
      'receiverId': widget.receiverId,
      'message': message,
      'imageUrls': imageUrls,
      'audioUrl': audioUrl ?? "",
      'timestamp': FieldValue.serverTimestamp(),
    });

    await _fireStore.collection('chats').doc(widget.chatId).update({
      'lastMessage': message.isNotEmpty
          ? message
          : (audioUrl != null ? 'Đã gửi tin nhắn thoại' : 'Đã gửi ảnh'),
      'lastTimestamp': FieldValue.serverTimestamp(),
    });

    setState(() {
      _selectedImages = [];
      _audioPath = null;
    });
  }

  Future<void> _pickImages() async {
    final List<XFile>? selectedImages = await _picker.pickMultiImage();
    if (selectedImages != null) {
      setState(() {
        _selectedImages = selectedImages;
      });
    }
  }

  List<XFile> _selectedImages = [];

  void _onVerticalDragUpdate(DragUpdateDetails details) {
    double dragAmount =
        details.primaryDelta! / MediaQuery.of(context).size.height;
    setState(() {
      _currentHeight = (_currentHeight - dragAmount).clamp(0.3, 0.8);
    });
  }

  void _removeImage(int index) {
    setState(() {
      _selectedImages.removeAt(index);
    });
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        hideKeyBoard();
        setState(() {
          _isRecording = false;
          showEmojis = false;
        });
      },
      child: Scaffold(
          appBar: isSelecting
              ? AppBar(
                  backgroundColor: Colors.blue,
                  leading: IconButton(
                    icon: const Icon(
                      Icons.cancel,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        selectedMessages.clear();
                        isSelecting = false;
                      });
                    },
                  ),
                  title: Text('${selectedMessages.length} tin nhắn đã chọn',
                      style: context.theme.textTheme.headlineSmall?.copyWith(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                  actions: [
                    IconButton(
                      icon: const Icon(
                        Icons.delete_outline,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        _deleteSelectedMessages();
                      },
                    ),
                  ],
                )
              : AppBar(
                  backgroundColor: Colors.blue,
                  leading: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      )),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.name,
                        style: context.theme.textTheme.headlineSmall?.copyWith(
                            color: Colors.white, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        'Đang hoạt động',
                        style: context.theme.textTheme.titleSmall?.copyWith(
                            color: Colors.white, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  actions: [
                    IconButton(
                      icon: const Icon(
                        Icons.call,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        showFeatureUnavailableDialog(context);
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.video_call_rounded,
                          color: Colors.white),
                      onPressed: () {
                        showFeatureUnavailableDialog(context);
                      },
                    ),
                    IconButton(
                      icon:
                          const Icon(Icons.list_outlined, color: Colors.white),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => GroupChatSettings(name:widget.name,),
                            ));
                        // showFeatureUnavailableDialog(context);
                      },
                    ),
                  ],
                ),
          body: Column(
            children: [
              // _buildMessageCard(context),
              Expanded(
                // child: StreamBuilder(
                //   stream: _fireStore
                //       .collection('chats')
                //       .doc(widget.chatId)
                //       .collection('messages')
                //       .orderBy('timestamp', descending: true)
                //       .snapshots(),
                //   builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                //     if (!snapshot.hasData) {
                //       return const Center(child: CircularProgressIndicator());
                //     }
                //     var messages = snapshot.data!.docs;
                //     return StreamBuilder(
                //       stream: FirebaseDatabase.instance
                //           .ref('chats/${widget.chatId}')
                //           .orderByChild('timestamp')
                //           .onValue,
                //       builder: (context, snapshot) {
                //         final data = Map<String, dynamic>.from(snapshot
                //             .data!.snapshot.value as Map<dynamic, dynamic>);
                //         final voicc = data.entries.toList()
                //           ..sort((a, b) => b.value['timestamp']
                //               .compareTo(a.value['timestamp']));
                //
                //         return ListView.builder(
                //           reverse: true,
                //           itemCount: messages.length + 1,
                //           itemBuilder: (context, index) {
                //             final voi = voicc[index].value;
                //             // final messageId = voicc[index].key;
                //             if (index == messages.length) {
                //               return _buildMessageCard(context, widget.name);
                //             }
                //             var messageData = messages[index];
                //             bool isMe =
                //                 messageData['senderId'] == widget.currentUserId;
                //             String messageId = messageData.id;
                //
                //             bool isSelected =
                //                 selectedMessages.contains(messageId);
                //             return !isSelecting
                //                 ? Container(
                //                     color: isSelected
                //                         ? Colors.blue.withOpacity(0.5)
                //                         : Colors.transparent,
                //                     child: _buildChatRow(
                //                       audioUrl:voi['content'],
                //                       // messageData['audioUrl'],
                //                       message: messageData['message'],
                //                       img: List<String>.from(
                //                           messageData['imageUrls'] ?? []),
                //                       isMe: isMe,
                //                       messageId: messageId,
                //                     ),
                //                   )
                //                 : ListTile(
                //                     leading: Checkbox(
                //                       value: isSelected,
                //                       onChanged: (bool? value) {
                //                         setState(() {
                //                           if (value == true) {
                //                             selectedMessages.add(messageId);
                //                           } else {
                //                             selectedMessages.remove(messageId);
                //                           }
                //                         });
                //                       },
                //                     ),
                //                     title: _buildChatRow(
                //                       // audioUrl: messageData['audioUrl'],
                //                       audioUrl:voi['content'],
                //                       message: messageData['message'],
                //                       img: List<String>.from(
                //                           messageData['imageUrls'] ?? []),
                //                       isMe: isMe,
                //                       messageId: messageId,
                //                     ),
                //                     onTap: () {
                //                       if (isSelecting) {
                //                         setState(() {
                //                           if (isSelected) {
                //                             selectedMessages.remove(
                //                                 messageId); // Bỏ chọn tin nhắn
                //                           } else {
                //                             selectedMessages.add(
                //                                 messageId); // Chọn tin nhắn
                //                           }
                //                         });
                //                       }
                //                     },
                //                   );
                //           },
                //         );
                //       },
                //     );
                //   },
                // ),
                child: StreamBuilder(
                  stream: _fireStore
                      .collection('chats')
                      .doc(widget.chatId)
                      .collection('messages')
                      .orderBy('timestamp', descending: true)
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    var messages = snapshot.data!.docs;

                    return ListView.builder(
                      reverse: true,
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        if (index == messages.length) {
                          return _buildMessageCard(context, widget.name);
                        }

                        var messageData = messages[index];
                        bool isMe = messageData['senderId'] == widget.currentUserId;
                        String messageId = messageData.id;

                        bool isSelected = selectedMessages.contains(messageId);

                        String? audioId = messageData['audioUrl']; // Giả sử audioUrl chứa ID trong Realtime Database

                        if (audioId == null) {
                          return Container(
                            color: isSelected ? Colors.blue.withOpacity(0.5) : Colors.transparent,
                            child: _buildChatRow(
                              audioUrl: '',
                              message: messageData['message'],
                              img: List<String>.from(messageData['imageUrls'] ?? []),
                              isMe: isMe,
                              messageId: messageId,
                            ),
                          );
                        }
                        // Tạo StreamBuilder để truy vấn Realtime Database bằng `audioId`
                        return StreamBuilder(
                          stream: FirebaseDatabase.instance.ref('voice/ffEgmSt7GMLGaKu0pcv4/$audioId').onValue,
                          builder: (context, AsyncSnapshot<DatabaseEvent> audioSnapshot) {
                            if (!audioSnapshot.hasData || audioSnapshot.data!.snapshot.value == null) {
                              // Nếu không có dữ liệu voice, hiển thị tin nhắn bình thường
                              return Container(
                                color: isSelected ? Colors.blue.withOpacity(0.5) : Colors.transparent,
                                child: _buildChatRow(
                                  audioUrl: "",
                                  message: messageData['message'],
                                  img: List<String>.from(messageData['imageUrls'] ?? []),
                                  isMe: isMe,
                                  messageId: messageId,
                                ),
                              );
                            }
                            final voiceData = Map<String, dynamic>.from(
                              audioSnapshot.data!.snapshot.value as Map<dynamic, dynamic>,
                            );
                            return Container(
                              color: isSelected ? Colors.blue.withOpacity(0.5) : Colors.transparent,
                              child: _buildChatRow(
                                audioUrl: voiceData['content']??"", // URL của voice từ Realtime Database
                                message: messageData['message'], // Tin nhắn từ Firestore
                                img: List<String>.from(messageData['imageUrls'] ?? []),
                                isMe: isMe,
                                messageId: messageId,
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
              _buildBottomInputArea(context, _messageController),
            ],
          )),
    );
  }

  Widget _buildChatRow(
      {required String audioUrl,
      required String message,
      required List<dynamic> img,
      required bool isMe,
      required String messageId}) {
    bool isCurrentVoicePlaying = (isPlaying && _currentPlayingUrl == audioUrl);
    return GestureDetector(
        onLongPress: () {
          _showDeleteMessageOptions(context, messageId, message);
        },
        child: Row(
          mainAxisAlignment:
              isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            if (!isMe)
              const CircleAvatar(
                backgroundImage: AssetImage(Asset.bgImageAvatar),
              ),
            SizedBox(
              width: context.width * 0.7,
              child: ChatBubble(
                isPlaying: isCurrentVoicePlaying,
                onPressed: () => playAudio(audioUrl),
                message: message,
                img: img,
                isMe: isMe,
                urlVoice: audioUrl,
              ),
            ),
          ],
        ));
  }

  void _showDeleteMessageOptions(
      BuildContext context, String messageId, String messageData) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: Colors.white,
          padding: const EdgeInsets.all(16.0),
          height: 250,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Tùy chọn tin nhắn',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              ListTile(
                leading: const Icon(Icons.delete, color: Colors.red),
                title: Text(selectedMessages.isNotEmpty
                    ? 'Xóa ${selectedMessages.length} tin nhắn'
                    : 'Xóa tin nhắn'),
                onTap: () {
                  if (selectedMessages.isNotEmpty) {
                    _deleteSelectedMessages();
                  } else {
                    _deleteMessage(messageId);
                  }
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading:
                    const Icon(Icons.checklist_outlined, color: Colors.blue),
                title: const Text('Chọn nhiều tin nhắn'),
                onTap: () {
                  setState(() {
                    isSelecting = true;
                  });
                  Navigator.pop(context);
                },
              ),
              if (selectedMessages.isEmpty)
                ListTile(
                  leading: const Icon(Icons.copy, color: Colors.blue),
                  title: const Text('Sao chép tin nhắn'),
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: messageData));
                    Navigator.pop(context);
                  },
                ),
            ],
          ),
        );
      },
    );
  }

  void _deleteSelectedMessages() {
    for (var messageId in selectedMessages) {
      _fireStore
          .collection('chats')
          .doc(widget.chatId)
          .collection('messages')
          .doc(messageId)
          .delete();
    }
    setState(() {
      selectedMessages.clear();
      isSelecting = false;
    });
  }

  void _deleteMessage(String messageId) {
    _fireStore
        .collection('chats')
        .doc(widget.chatId)
        .collection('messages')
        .doc(messageId)
        .delete();
  }

  Widget _buildBottomInputArea(
      BuildContext context, TextEditingController controller) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: const BorderRadius.all(Radius.circular(20))),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.add_reaction_outlined,
                    color: Colors.black54),
                onPressed: () {
                  setState(() {
                    showEmojis = !showEmojis;
                    _isRecording = false;
                    showImg = false;
                    _currentHeight = 0.3;
                  });
                },
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: TextField(
                  decoration: const InputDecoration(
                    hintText: 'Tin nhắn',
                    border: InputBorder.none,
                  ),
                  controller: controller,
                  onSubmitted: (value) {
                    _sendMessage();
                  },
                  onChanged: (value) {
                    setState(() {
                      controller.text = value;
                    });
                  },
                ),
              ),
              if (controller.text.isEmpty && _selectedImages.isEmpty) ...{
                InkWell(
                  onTap: () {
                    showFeatureUnavailableDialog(context);
                  },
                  child: const Icon(Icons.more_horiz_outlined,
                      color: Colors.black54),
                ),
                const SizedBox(width: 8.0),
                IconButton(
                  icon: _isRecording
                      ? const Icon(Icons.mic, color: Colors.blue)
                      : const Icon(Icons.mic_none, color: Colors.black54),
                  onPressed: () {
                    setState(() {
                      _isRecording = !_isRecording;
                      showEmojis = false;
                      showImg = false;
                      _currentHeight = 0.3;
                    });
                  },
                ),
                const SizedBox(width: 8.0),
                InkWell(
                  onTap: () {
                    // loadImages();
                    _pickImages();
                    setState(() {
                      // showImg = !showImg;
                      _isRecording = false;
                      showEmojis = false;
                      _currentHeight = 0.3;
                    });
                  },
                  child: Icon(Icons.image_outlined,
                      color: showImg ? Colors.blue : Colors.black54),
                ),
              } else
                // if (controller.text.isNotEmpty)
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.blue),
                  onPressed: _sendMessage,
                ),
            ],
          ),
        ),
        if (showEmojis)
          SizedBox(
            height: context.height * 0.35,
            child: EmojiPicker(
              onEmojiSelected: (category, emoji) {
                setState(() {
                  _messageController.text += emoji.emoji;
                });
              },
            ),
          ),
        if (_isRecording)
          SizedBox(
            height: context.height * 0.35,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Turn on or hold to record",
                  style: context.theme.textTheme.headlineSmall,
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  // onTap: () {
                  // showFeatureUnavailableDialog(context);
                  // _stopRecordingAndSendMessage();
                  // },
                  onLongPress: _startRecording,
                  onLongPressUp: _stopRecordingAndSendMessage,
                  child: CircleAvatar(
                      radius: 30,
                      backgroundColor: _isRecording ? Colors.blue : Colors.red,
                      child: const Icon(
                        Icons.mic,
                        color: Colors.white,
                      )),
                ),
              ],
            ),
          ),
        if (_selectedImages.isNotEmpty)
          SizedBox(
            height: context.height * 0.35,
            child: GridView.builder(
              scrollDirection: Axis.vertical,
              itemCount: _selectedImages.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                mainAxisSpacing: 8,
              ),
              itemBuilder: (context, index) {
                return Container(
                  width: 50,
                  height: 50,
                  alignment: Alignment.topRight,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: FileImage(File(_selectedImages[index].path)),
                    fit: BoxFit.fitHeight,
                  )),
                  child: IconButton(
                    icon: const Icon(Icons.cancel),
                    onPressed: () => _removeImage(index),
                  ),
                );
                // Stack(
                // children: [
                // Image.file(
                // File(_selectedImages[index].path),
                // fit: BoxFit.cover,
                // width: 100,
                // height: 100,
                // ),
                // Positioned(
                // top: 0,
                // right: 0,
                // child: IconButton(
                // icon: const Icon(Icons.close, color: Colors.red),
                // onPressed: () => _removeImage(index),
                // ),
                // ),
                // ],
                // );
              },
            ),
          ),
        // if (showImg)
        //   GestureDetector(
        //     onVerticalDragUpdate: _onVerticalDragUpdate,
        //     child: Container(
        //       height: MediaQuery.of(context).size.height * _currentHeight,
        //       color: Colors.white,
        //       child: GridView.builder(
        //         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        //           crossAxisCount: 3,
        //           crossAxisSpacing: 2,
        //           mainAxisSpacing: 2,
        //         ),
        //         itemCount: images.length,
        //         itemBuilder: (context, index) {
        //           return GestureDetector(
        //             onTap: () => onImageTap(index),
        //             child: Stack(
        //               children: [
        //                 thumbnails[index] != null
        //                     ? Image.memory(thumbnails[index]!,
        //                         fit: BoxFit.cover,
        //                         width: double.infinity,
        //                         height: double.infinity)
        //                     : const Center(child: CircularProgressIndicator()),
        //                 // Hiển thị checkbox khi ảnh được chọn
        //                 if (selectedImages[index])
        //                   const Positioned(
        //                     top: 8,
        //                     right: 8,
        //                     child: Icon(Icons.check_circle,
        //                         color: Colors.blue, size: 24),
        //                   ),
        //               ],
        //             ),
        //           );
        //         },
        //       ),
        //     ),
        //   )
      ],
    );
  }
}

Widget _buildMessageCard(BuildContext context, String name) {
  return Container(
    height: context.height * 0.25,
    width: context.width * 0.6,
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    margin: const EdgeInsets.symmetric(horizontal: 30),
    alignment: Alignment.bottomLeft,
    decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        image: DecorationImage(
            image: AssetImage(Asset.bgCardMessage), fit: BoxFit.fitWidth)),
    child: ListTile(
      leading: const CircleAvatar(
        backgroundImage: AssetImage(Asset.bgImageUser),
      ),
      title: Text(
        name,
        style: context.theme.textTheme.titleMedium,
      ),
      subtitle: Text(
        "Let's start this conversation with great stories",
        style: context.theme.textTheme.titleSmall?.copyWith(fontSize: 10),
      ),
    ),
  );
}
