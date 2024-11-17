import 'dart:convert';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:ui_youtex/bloc/cart_bloc/cart_bloc.dart';
import 'package:ui_youtex/bloc/forgot_password_bloc/forgot_password_bloc.dart';
import 'package:ui_youtex/bloc/product_bloc_bloc/product_bloc_bloc.dart';
import 'package:ui_youtex/bloc_seller/bloc_seller_address_bloc/bloc_seller_address_bloc.dart';
import 'package:ui_youtex/bloc_seller/bloc_seller_register_status_bloc.dart/seller_register_status_bloc.dart';
import 'package:ui_youtex/bloc_seller/seller_product_Shiping_bloc_bloc/seller_product_extra_bloc_bloc.dart';
import 'package:ui_youtex/bloc_seller/seller_product_details_bloc_bloc/seller_product_details_bloc_bloc.dart';
import 'package:ui_youtex/bloc_seller/seller_product_extra_bloc_bloc/seller_product_extra_bloc_bloc.dart';
import 'package:ui_youtex/bloc_seller/seller_product_sales_bloc_bloc/seller_product_sales_bloc_bloc.dart';
import 'package:ui_youtex/bloc_seller/seller_register_identification_bloc/seller_register_identification_bloc_bloc.dart';
import 'package:ui_youtex/bloc_seller/seller_register_product_bloc_bloc/seller_register_product_bloc_bloc.dart';
import 'package:ui_youtex/bloc_seller/seller_register_tax_get_bloc/seller_register_tax_get_bloc_bloc.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'dart:core';
import 'package:ui_youtex/pages/screens/home/home.dart';
import 'package:ui_youtex/pages/screens/mall/user_mail/user_mall_product_seller/user_mail_shop_product.dart';
import 'package:ui_youtex/pages/screens/member_Vip/free_trail.dart';
import 'package:ui_youtex/pages/screens/member_Vip/member_packagePayment.dart';
import 'package:ui_youtex/pages/screens/message/group_chat_settings/group_chat_settings.dart';
import 'package:ui_youtex/pages/screens/shopping_cart_page/payment_method_screen/payment_method_screen%20copy.dart';
import 'package:ui_youtex/pages/screens/shopping_cart_page/payment_method_screen/payment_method_screen.dart';
import 'package:ui_youtex/pages/splash/Welcome/Register/RegisterScreen.dart';
import 'package:ui_youtex/pages/splash/Welcome/Register/resetPass/forgotPass_Screen.dart';
import 'package:ui_youtex/pages/splash/Welcome/Register/resetPass/resetPassDone_screen.dart';
import 'package:ui_youtex/pages/splash/Welcome/Register/resetPass/resetPassOtp_screen.dart';
import 'package:ui_youtex/pages/splash/Welcome/Register/resetPass/resetPass_screen.dart';
import 'package:ui_youtex/pages/splash/Welcome/welcome.dart';
import 'package:ui_youtex/pages/widget_small/bottom_navigation/bottom_navigation.dart';
import 'package:ui_youtex/services/restful_api_provider.dart';
import 'bloc/edit_profile_bloc/edit_profile_bloc.dart';
import 'bloc/login_bloc/login_bloc.dart';
import 'bloc/register_bloc/register_bloc.dart';
import 'bloc/search_user_bloc/fetch_user_by_phone_bloc.dart';
import 'bloc/user_profile_bloc/user_profile_bloc.dart';
import 'bloc_seller/seller_register_bloc/seller_register_bloc.dart';
import 'core/themes/theme_data.dart';
import 'pages/splash/Welcome/Register/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
              apiKey: 'AIzaSyB5wk6mb440sCUyvRyZqgOMxY1GL3adLhE',
              appId: '1:154408670652:android:9ffbe52d803e2ff3ed07b9',
              messagingSenderId: '154408670652',
              projectId: 'youtextile-90dbc',
              storageBucket: "youtextile-90dbc.firebasestorage.app"))
      : await Firebase.initializeApp();
  final apiProvider = RestfulApiProviderImpl();

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<RestfulApiProviderImpl>.value(
          value: apiProvider,
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => RegisterBloc(),
          ),
          BlocProvider(
            create: (context) => EditProfileBloc(),
          ),
          BlocProvider(
            create: (context) => UserProfileBloc(),
          ),
          BlocProvider(
            create: (context) => EditProfileBloc(),
          ),
          BlocProvider(
            create: (context) => ForgotPasswordBloc(),
          ),
          BlocProvider(
            create: (context) => LoginBloc(),
          ),
          BlocProvider(
            create: (context) => SellerAddressBloc(
              restfulApiProvider: apiProvider,
            ),
          ),
          BlocProvider(
            create: (context) => FetchUserByPhoneBloc(),
          ),
          BlocProvider(
            create: (context) => CartBloc(),
          ),
          BlocProvider(
            create: (context) => ProductBlocBloc(
              restfulApiProvider: apiProvider,
            ),
            // create: (context) => FetchUserByPhoneBloc(),
          ),
          BlocProvider(
            create: (context) => SellerRegisterProductBloc(
              restfulApiProvider: apiProvider,
            ),
          ),
          BlocProvider(
            create: (context) => SellerRegisterIdentificationBlocBloc(
              restfulApiProvider: apiProvider,
            ),
          ),
          BlocProvider(
            create: (context) => SellerRegisterBloc(
              restfulApiProvider: apiProvider,
            ),
          ),
          // BlocProvider(
          //   create: (context) => SellerRegisterAddressBloc(
          //     restfulApiProvider: apiProvider,
          //   ),
          // ),SellerRegisterStatusBloc
          BlocProvider(
            create: (context) => SellerRegisterTaxBloc(
              restfulApiProvider: apiProvider,
            ),
          ),
          BlocProvider(
            create: (context) => SellerRegisterStatusBloc(
              restfulApiProvider: apiProvider,
            ),
          ),
          BlocProvider(
            create: (context) => ProductDetailsBloc(
              restfulApiProvider: apiProvider,
            ),
          ),
          BlocProvider(
            create: (context) => SellerProductSalesBloc(
              restfulApiProvider: apiProvider,
            ),
          ),
          BlocProvider(
            create: (context) => SellerProductExtraBloc(
              restfulApiProvider: apiProvider,
            ),
          ),
          BlocProvider(
            create: (context) => SellerProductShipingBloc(
              restfulApiProvider: apiProvider,
            ),
          ),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: MyAppThemes.lightTheme,
      debugShowCheckedModeBanner: false,

      // home: const WelcomeApp(),
      home: const CustomNavBar(),
      // home: const VoiceChatScreen(chatId: "ffEgmSt7GMLGaKu0pcv4",currentUserId: "0812507355",),
      // home: const ChatScreen(chatId: 'ffEgmSt7GMLGaKu0pcv4',currentUserId: "0812507455",),
        // home: const GroupChatSettings(),
       // home: const RegisterMallScreen(),
      // home: const UploadImageScreen(),
      // home: const ImageGalleryScreen(),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        // '/home': (context) => const HomePage(),
        '/memberVip': (context) => const FreeTrialTimeline(),
        '/CustomNavBar': (context) => const CustomNavBar(),
        '/Forgot': (context) => const ForgotScreen(),
        '/OTP': (context) => const OTPScreen(),
        '/Reset': (context) => const ResetpassScreen(),
        '/Resetpass': (context) => const ResetpassdoneScreen(),
        '/MembershipPaymentScreen': (context) =>
            const MembershipPaymentScreen(),
        '/PaymentMethodScreen': (context) => const PaymentMethodScreen(),
        '/PaymentMethodPayScreen': (context) => const PaymentMethodPayScreen(),
        '/product_management': (context) => const ProductManagementScreen(),
      },
    );
  }
}
class ImageDetailScreen extends StatefulWidget {
  const ImageDetailScreen({super.key});

  @override
  _ImageDetailScreenState createState() => _ImageDetailScreenState();
}

class _ImageDetailScreenState extends State<ImageDetailScreen> {
  final DatabaseReference _databaseRef = FirebaseDatabase.instance.ref('chat_images');
  List<Map<String, dynamic>> images = [];
  List<String> imageIds = [
    "EzrP8mHgLB25XGNy15HQ_image_1731607664496",
    // Thêm các ID khác
  ];

  @override
  void initState() {
    super.initState();
    fetchImagesByIds();
  }

  Future<void> fetchImagesByIds() async {
    List<Map<String, dynamic>> fetchedImages = [];
    for (String id in imageIds) {
      final snapshot = await _databaseRef.child(id).get();
      if (snapshot.exists) {
        final data = snapshot.value as Map<dynamic, dynamic>;
        fetchedImages.add({
          "id": id,
          "base64": data["base64"],
          "fileName": data["fileName"],
          "senderId": data["senderId"],
          "timestamp": data["timestamp"],
        });
      }
    }
    setState(() {
      images = fetchedImages;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Image Details')),
      body: images.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: images.length,
        itemBuilder: (context, index) {
          final image = images[index];
          return ListTile(
            leading: Image.memory(
              base64Decode(image["base64"]),
              fit: BoxFit.cover,
              width: 50,
              height: 50,
            ),
            title: Text(image["fileName"]),
            subtitle: Text('Sender ID: ${image["senderId"]}'),
          );
        },
      ),
    );
  }
}

class ChatScreen extends StatefulWidget {
  final String chatId;
  final String currentUserId;

  const ChatScreen({
    super.key,
    required this.chatId,
    required this.currentUserId,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final DatabaseReference _databaseRef = FirebaseDatabase.instance.ref();
  List<Map<String, dynamic>> _messages = [];
  bool _isLoading = true;
  final AudioPlayer _audioPlayer = AudioPlayer(); // Player cho audio

  @override
  void initState() {
    super.initState();
    _listenToMessages(); // Lấy dữ liệu liên tục từ Firebase
  }

  @override
  void dispose() {
    _audioPlayer.dispose(); // Dọn dẹp audio player
    super.dispose();
  }

  // Lắng nghe tin nhắn mới từ Realtime Database
  void _listenToMessages() {
    _databaseRef.child('chats/${widget.chatId}').onValue.listen((event) {
      final data = event.snapshot.value as Map?;
      if (data != null) {
        final messages = data.entries.map((entry) {
          return {
            "id": entry.key,
            ...Map<String, dynamic>.from(entry.value as Map),
          };
        }).toList();
        setState(() {
          _messages = messages..sort((a, b) => b['timestamp'].compareTo(a['timestamp']));
          _isLoading = false;
        });
      } else {
        setState(() {
          _messages = [];
          _isLoading = false;
        });
      }
    });
  }

  // Hàm phát audio
  Future<void> _playAudio(String url) async {
    try {
      await _audioPlayer.play(UrlSource(url));
    } catch (e) {
      print("Error playing audio: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Voice Chat'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: _messages.length,
        itemBuilder: (context, index) {
          final message = _messages[index];
          if (message['type'] == 'audio') {
            return ListTile(
              title: const Text('Voice Message'),
              subtitle: Text('Sent at: ${DateTime.fromMillisecondsSinceEpoch(message['timestamp'])}'),
              trailing: IconButton(
                icon: const Icon(Icons.play_arrow),
                onPressed: () => _playAudio(message['content']),
              ),
            );
          } else {
            return ListTile(
              title: Text(message['content']),
              subtitle: Text('Sent at: ${DateTime.fromMillisecondsSinceEpoch(message['timestamp'])}'),
            );
          }
        },
      ),
    );
  }
}


class VoiceChatScreen extends StatefulWidget {
  final String currentUserId;
  final String chatId;

  const VoiceChatScreen({
    required this.currentUserId,
    required this.chatId,
    Key? key,
  }) : super(key: key);

  @override
  _VoiceChatScreenState createState() => _VoiceChatScreenState();
}

class _VoiceChatScreenState extends State<VoiceChatScreen> {
  FlutterSoundRecorder? _recorder;
  String? _recordedFilePath;
  List<Map<String, dynamic>> _messages = [];
  bool _isRecording = false;
  String? _audioPath;

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
      _recordedFilePath = path;
    }
  }

  // Hàm gửi dữ liệu lên Realtime Database
  Future<void> _uploadAudio() async {
    await _stopRecordingAndSendMessage();
    if (_recordedFilePath == null) return;
    try {
      Map<String, dynamic> newMessage = {
        "senderId": widget.currentUserId,
        "type": "audio",
        "content": _recordedFilePath,
        "timestamp": DateTime.now().millisecondsSinceEpoch,
      };

      DatabaseReference messageRef =
      FirebaseDatabase.instance.ref('chats/${widget.chatId}').push();
      await messageRef.set(newMessage);

      setState(() {
        _messages.add(newMessage);
      });

      print('Message uploaded to Realtime Database successfully.');
    } catch (e) {
      print('Error uploading audio: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Voice Chat')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                if (message['type'] == 'audio') {
                  return ListTile(
                    title: const Text('Voice Message'),
                    subtitle: Text('Sent by: ${message['senderId']}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.play_arrow),
                      onPressed: () {
                        print('Playing audio: ${message['content']}');
                      },
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                ElevatedButton.icon(
                  onPressed: _startRecording,
                  icon: const Icon(Icons.mic),
                  label: const Text('Record'),
                ),
                const SizedBox(width: 8),
                ElevatedButton.icon(
                  onPressed: _uploadAudio,
                  icon: const Icon(Icons.send),
                  label: const Text('Send'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
class ImageDisplay extends StatefulWidget {
  const ImageDisplay({super.key});

  @override
  _ImageDisplayState createState() => _ImageDisplayState();
}

class _ImageDisplayState extends State<ImageDisplay> {
  final DatabaseReference _databaseRef = FirebaseDatabase.instance.ref("chat_images");
  Uint8List? _imageData;

  @override
  void initState() {
    super.initState();
    _fetchImageData();
  }

  void _fetchImageData() async {
    final DataSnapshot snapshot = await _databaseRef.child("EzrP8mHgLB25XGNy15HQ_image_1731607664496").get();
    final String base64Image = snapshot.child("base64").value as String;

    setState(() {
      _imageData = base64Decode(base64Image);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Display Image")),
      body: Center(
        child: _imageData != null
            ? Image.memory(_imageData!)
            : const CircularProgressIndicator(),
      ),
    );
  }
}


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  final ImagePicker _picker = ImagePicker();
  List<String> _imageBase64List = [];

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      _uploadImage(File(image.path));
    }
  }

  Future<void> _uploadImage(File imageFile) async {
    try {
      // Đọc dữ liệu hình ảnh và chuyển sang base64
      List<int> imageBytes = await imageFile.readAsBytes();
      String base64Image = base64Encode(imageBytes);

      // Lưu base64 vào Firebase Realtime Database
      DatabaseReference ref = FirebaseDatabase.instance.ref('images');
      String imageId = ref.push().key!;
      await ref.child(imageId).set({
        'base64': base64Image,
        'fileName': imageFile.path.split('/').last,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      });

      setState(() {
        _imageBase64List.add(base64Image);
      });
    } catch (e) {
      print("Error uploading image: $e");
    }
  }

  Future<void> _loadImages() async {
    DatabaseReference ref = FirebaseDatabase.instance.ref('images');
    ref.onChildAdded.listen((event) {
      String base64Image = event.snapshot.child('base64').value as String;
      setState(() {
        _imageBase64List.add(base64Image);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _loadImages(); // Tải hình ảnh khi trang được mở
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gửi Hình Ảnh'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: _pickImage,
            child: Text('Chọn Hình Ảnh'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _imageBase64List.length,
              itemBuilder: (context, index) {
                return Image.memory(
                  base64Decode(_imageBase64List[index]), // Hiển thị hình ảnh từ base64
                  fit: BoxFit.cover,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
// class ChatScreen extends StatefulWidget {
//   const ChatScreen({super.key});
//
//   @override
//   _ChatScreenState createState() => _ChatScreenState();
// }
//
// class _ChatScreenState extends State<ChatScreen> {
//   final TextEditingController _messageController = TextEditingController();
//   final ImagePicker _picker = ImagePicker();
//   List<XFile> _selectedImages = [];
//
//   // Hàm chọn nhiều ảnh
//   Future<void> _pickImages() async {
//     final List<XFile>? selectedImages = await _picker.pickMultiImage();
//     if (selectedImages != null) {
//       setState(() {
//         _selectedImages = selectedImages;
//       });
//     }
//   }
//
//   // Hàm gửi tin nhắn và ảnh
//   void _sendMessage() async {
//     String message = _messageController.text.trim();
//     _messageController.clear();
//
//     if (message.isEmpty && _selectedImages.isEmpty) return;
//
//
//     setState(() {
//       _selectedImages = []; // Xoá ảnh sau khi gửi
//     });
//   }
//
//   // Hàm xoá một ảnh khỏi danh sách
//   void _removeImage(int index) {
//     setState(() {
//       _selectedImages.removeAt(index);
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           // Hiển thị các ảnh đã chọn
//           if (_selectedImages.isNotEmpty)
//             SizedBox(
//               height: 100,
//               child: GridView.builder(
//                 scrollDirection: Axis.horizontal,
//                 itemCount: _selectedImages.length,
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 1,
//                   mainAxisSpacing: 8,
//                 ),
//                 itemBuilder: (context, index) {
//                   return Stack(
//                     children: [
//                       Image.file(
//                         File(_selectedImages[index].path),
//                         fit: BoxFit.cover,
//                         width: 100,
//                         height: 100,
//                       ),
//                       Positioned(
//                         top: 0,
//                         right: 0,
//                         child: IconButton(
//                           icon: Icon(Icons.close, color: Colors.red),
//                           onPressed: () => _removeImage(index),
//                         ),
//                       ),
//                     ],
//                   );
//                 },
//               ),
//             ),
//
//           // Trường nhập tin nhắn và các nút
//           Row(
//             children: [
//               IconButton(
//                 icon: Icon(Icons.image),
//                 onPressed: _pickImages,
//               ),
//               Expanded(
//                 child: TextField(
//                   controller: _messageController,
//                   decoration:
//                       const InputDecoration(labelText: 'Nhập tin nhắn...'),
//                 ),
//               ),
//               IconButton(
//                 icon: Icon(Icons.send),
//                 onPressed: _sendMessage,
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
