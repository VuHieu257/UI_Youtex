//
// class SearchUserByPhoneScreen extends StatefulWidget {
//   const SearchUserByPhoneScreen({super.key});
//
//   @override
//   State<SearchUserByPhoneScreen> createState() =>
//       _SearchUserByPhoneScreenState();
// }
//
// class _SearchUserByPhoneScreenState extends State<SearchUserByPhoneScreen> {
//   final TextEditingController _phoneController = TextEditingController();
//
//   @override
//   void dispose() {
//     _phoneController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Search User by Phone'),
//       ),
//       body: BlocBuilder<FetchUserByPhoneBloc, FetchUserByPhoneState>(
//           builder: (context, state) {
//             if (state is UserLoading) {
//               return const CircularProgressIndicator();
//             }
//             return Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 children: [
//                   Row(
//                     children: [
//                       Expanded(
//                         flex: 3,
//                         child: Container(
//                           // padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
//                           margin: const EdgeInsets.symmetric(horizontal: 10),
//                           alignment: Alignment.center,
//                           decoration: BoxDecoration(
//                             color: const Color(0xffF3F3F3),
//                             borderRadius: BorderRadius.circular(20),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.black.withOpacity(0.25),
//                                 offset: const Offset(0, 4),
//                                 blurRadius: 4,
//                               ),
//                             ],
//                           ),
//                           child: TextField(
//                             controller: _phoneController,
//                             decoration: const InputDecoration(
//                               hintText: 'Tìm kiếm bạn bè',
//                               prefixIcon: Icon(Icons.search),
//                               border: InputBorder.none,
//                             ),
//                           ),
//                         ),
//                       ),
//                       Expanded(
//                         child: GestureDetector(
//                           onTap: () {
//                             final phone = _phoneController.text;
//                             if (phone.isNotEmpty) {
//                               // Dispatch the event to the bloc
//                               context
//                                   .read<FetchUserByPhoneBloc>()
//                                   .add(FetchUserByPhone(phone));
//                               FocusScope.of(context).unfocus(); // Hide the keyboard
//                             }
//                           },
//                           child: Container(
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 20, vertical: 8),
//                             margin: const EdgeInsets.symmetric(horizontal: 5),
//                             decoration: BoxDecoration(
//                                 boxShadow: [
//                                   BoxShadow(
//                                       color: Colors.black.withOpacity(0.25),
//                                       offset: const Offset(0, 4),
//                                       blurRadius: 4)
//                                 ],
//                                 borderRadius: BorderRadius.circular(18),
//                                 color: const Color(0xffF3F3F3)),
//                             child: const Icon(Icons.done_all),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   if (state is UserLoaded) ...{
//                     FriendCard(
//                       id: state.id,
//                       name: state.name,
//                       img: "${state.img}",
//                     ),
//                   }
//                 ],
//               ),
//             );
//           }),
//     );
//   }
// }
//
// final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
// Future<void> addFriend(
//     String userId, String friendId, String name, String? imgUrl) async {
//   try {
//     await _firestore
//         .collection('users')
//         .doc(userId)
//         .collection('friends')
//         .doc(friendId)
//         .set({
//       'id': friendId,
//       'name': name,
//       'image': imgUrl,
//       'addedAt': FieldValue.serverTimestamp(),
//     });
//     if (kDebugMode) {
//       print("Friend added successfully");
//     }
//   } catch (e) {
//     if (kDebugMode) {
//       print("Failed to add friend: $e");
//     }
//   }
// }
//
// void createNewChat(
//     BuildContext context, String currentUserId, String otherUserId) async {
//   final chatDocRef = _firestore.collection('chats').doc();
//
//   await chatDocRef.set({
//     'participants': [currentUserId, otherUserId],
//     'lastMessage': '',
//     'lastTimestamp': FieldValue.serverTimestamp(),
//   });
//
//   // Điều hướng tới màn hình chat
//   // Navigator.push(
//   //   context,
//   //   MaterialPageRoute(
//   //     builder: (context) => ChatScreen(
//   //       chatId: chatDocRef.id,
//   //       receiverId: otherUserId,
//   //       receiverName: 'Tên của người nhận',
//   //     ),
//   //   ),
//   // );
// }
//
// class FriendCard extends StatelessWidget {
//   final String name;
//   final String img;
//   final String id;
//
//   const FriendCard(
//       {super.key, required this.name, required this.img, required this.id});
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//       child: Card(
//         color: const Color(0xffF3F3F3),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(16),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Row(
//             children: [
//               Container(
//                 height: context.width * 0.15,
//                 width: context.width * 0.15,
//                 decoration: BoxDecoration(
//                   borderRadius: const BorderRadius.all(Radius.circular(12)),
//                   image: DecorationImage(
//                       image: img.isEmpty || img == "null"
//                           ? const AssetImage(Asset.bgImageAvatar)
//                           : NetworkImage(
//                           "${NetworkConstants.urlImage}/storage/$img")
//                       as ImageProvider,
//                       fit: BoxFit.cover),
//                 ),
//               ),
//               const SizedBox(width: 10),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       name,
//                       style: context.theme.textTheme.titleMedium?.copyWith(
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     Text(
//                       'Member ID: $id',
//                       style: context.theme.textTheme.titleMedium?.copyWith(
//                         fontSize: 10,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               GestureDetector(
//                 onTap: () => createNewChat(
//                   context,
//                   "0812507355",
//                   "0812507356",
//                 ),
//                 child: Container(
//                   margin: const EdgeInsets.only(right: 10),
//                   padding: const EdgeInsets.all(10),
//                   decoration: BoxDecoration(
//                     boxShadow: [
//                       BoxShadow(
//                           color: Colors.black.withOpacity(0.25),
//                           offset: const Offset(0, 4),
//                           blurRadius: 4),
//                     ],
//                     color: Styles.blue,
//                     borderRadius: const BorderRadius.all(Radius.circular(10)),
//                   ),
//                   child: Text(
//                     'Nhắn tin',
//                     style: context.theme.textTheme.titleSmall?.copyWith(
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//               ),
//               GestureDetector(
//                 onTap: () {
//                   addFriend("0812507355", "0812507356", name, img);
//                 },
//                 child: Container(
//                   padding: const EdgeInsets.all(10),
//                   decoration: BoxDecoration(
//                     boxShadow: [
//                       BoxShadow(
//                           color: Colors.black.withOpacity(0.25),
//                           offset: const Offset(0, 4),
//                           blurRadius: 4),
//                     ],
//                     color: const Color(0xffFF6B6B),
//                     borderRadius: const BorderRadius.all(Radius.circular(10)),
//                   ),
//                   child: Text(
//                     'Kết bạn',
//                     style: context.theme.textTheme.titleSmall?.copyWith(
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class FriendsList extends StatelessWidget {
//   final String userId;
//
//   const FriendsList({super.key, required this.userId});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: StreamBuilder<List<Map<String, dynamic>>>(
//         stream: getFriends(userId),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const CircularProgressIndicator();
//           }
//
//           if (snapshot.hasError) {
//             return Text("Error: ${snapshot.error}");
//           }
//
//           final friends = snapshot.data;
//
//           if (friends == null || friends.isEmpty) {
//             return const Text("No friends added yet.");
//           }
//
//           return ListView.builder(
//             itemCount: friends.length,
//             itemBuilder: (context, index) {
//               final friend = friends[index];
//               return ListTile(
//                 leading: friend['image'] != null
//                     ? Image.network(friend['image'], width: 50, height: 50)
//                     : const Icon(Icons.person, size: 50),
//                 title: Text(friend['name'] ?? 'Unknown'),
//                 subtitle: Text(friend['addedAt'] != null
//                     ? 'Added on ${friend['addedAt'].toDate()}'
//                     : 'Date not available'),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
//
//   Stream<List<Map<String, dynamic>>> getFriends(String userId) {
//     return FirebaseFirestore.instance
//         .collection('users')
//         .doc(userId)
//         .collection('friends')
//         .snapshots()
//         .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
//   }
// }
//
// class ChatListScreen extends StatelessWidget {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
//
//   ChatListScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     // String currentUserId = _auth.currentUser!.uid;
//     void createNewChat(String currentUserId, String otherUserId) async {
//       final chatDocRef = _fireStore.collection('chats').doc();
//
//       await chatDocRef.set({
//         'participants': [currentUserId, otherUserId],
//         'lastMessage': '',
//         'lastTimestamp': FieldValue.serverTimestamp(),
//       });
//
//       // Điều hướng tới màn hình chat
//       // Navigator.push(
//       //   context,
//       //   MaterialPageRoute(
//       //     builder: (context) => ChatScreen(
//       //       chatId: chatDocRef.id,
//       //       receiverId: otherUserId,
//       //       receiverName: 'Tên của người nhận',
//       //     ),
//       //   ),
//       // );
//     }
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Các cuộc trò chuyện"),
//         actions: [
//           InkWell(
//               onTap: () {
//                 createNewChat("user1", "user2");
//               },
//               child: const Icon(Icons.add_box_outlined))
//         ],
//       ),
//       body: StreamBuilder(
//         stream: _fireStore
//             .collection('chats')
//         // .where('participants', arrayContains: currentUserId)
//             .where('participants', arrayContains: "user1")
//             .orderBy('lastTimestamp', descending: true)
//             .snapshots(),
//         builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (!snapshot.hasData) {
//             return const Center(child: CircularProgressIndicator());
//           }
//
//           var chatDocs = snapshot.data!.docs;
//
//           if (chatDocs.isEmpty) {
//             return const Center(child: Text("Không có cuộc trò chuyện nào"));
//           }
//
//           return ListView.builder(
//             itemCount: chatDocs.length,
//             itemBuilder: (context, index) {
//               var chat = chatDocs[index];
//               var participants = chat['participants'] as List;
//
//               // Lấy ra ID của người nhận (người không phải là user hiện tại)
//               // String otherUserId = participants.firstWhere((id) => id != currentUserId);
//               String otherUserId =
//               participants.firstWhere((id) => id != "user1");
//
//               return FutureBuilder(
//                 future: _fireStore.collection('users').doc("user2").get(),
//                 // Lấy thông tin người nhận
//                 builder:
//                     (context, AsyncSnapshot<DocumentSnapshot> userSnapshot) {
//                   if (!userSnapshot.hasData) {
//                     return const ListTile(title: Text("Loading..."));
//                   }
//
//                   var userData =
//                   userSnapshot.data!.data() as Map<String, dynamic>;
//                   String otherUserName = userData['name'];
//
//                   return ListTile(
//                     title: Text(otherUserName),
//                     subtitle: Text(chat['lastMessage']),
//                     onTap: () {
//                       // Navigator.push(
//                       //   context,
//                       //   MaterialPageRoute(
//                       //     builder: (context) => ChatScreen(
//                       //       chatId: chat.id,
//                       //       receiverId: otherUserId,
//                       //       receiverName: otherUserName,
//                       //     ),
//                       //   ),
//                       // );
//                     },
//                   );
//                 },
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }




///img
///
///
// class ImageGalleryScreen extends StatefulWidget {
//   const ImageGalleryScreen({super.key});
//
//   @override
//   State<ImageGalleryScreen> createState() => _ImageGalleryScreenState();
// }
//
// class _ImageGalleryScreenState extends State<ImageGalleryScreen> {
//   List<AssetEntity> images = [];
//   List<Uint8List?> thumbnails = [];
//   List<bool> selectedImages = [];
//   List<String> uploadedUrls = [];
//
//   @override
//   void initState() {
//     super.initState();
//     loadImages();
//   }
//
//   Future<void> loadImages() async {
//     final albums = await PhotoManager.getAssetPathList(type: RequestType.image);
//     final recentAlbum = albums.first;
//     final recentImages = await recentAlbum.getAssetListRange(start: 0, end: 100);
//     final status = await Permission.storage.request();
//
//     if (status != PermissionStatus.granted) {
//       print("Permission denied for accessing photos.");
//       return;
//     }
//     // Tải thumbnail và lưu vào cache
//     List<Uint8List?> thumbnailDataList = await Future.wait(
//       recentImages.map((image) => image.thumbnailData).toList(),
//     );
//
//     setState(() {
//       images = recentImages;
//       thumbnails = thumbnailDataList;
//       selectedImages = List<bool>.filled(images.length, false);
//     });
//   }
//
//   void onImageTap(int index) {
//     setState(() {
//       selectedImages[index] = !selectedImages[index];
//     });
//   }
//   // Future<String?> uploadImage(Uint8List imageData, String imageName) async {
//   //   try {
//   //     if (imageData.isEmpty) {
//   //       print("Image data is empty for image: $imageName");
//   //       return null;
//   //     }
//   //
//   //     print("${imageData}===============================================");
//   //     final storageRef = FirebaseStorage.instance.ref().child("uploads/imageName");
//   //     final uploadTask = storageRef.putData(imageData);
//   //
//   //     final snapshot = await uploadTask.whenComplete(() {
//   //       print("Upload complete for: $imageName");
//   //     });
//   //
//   //     final downloadUrl = await snapshot.ref.getDownloadURL();
//   //     print("Download URL for $imageName: $downloadUrl");
//   //     return downloadUrl;
//   //   } catch (e) {
//   //     print("Error uploading image: $e");
//   //     return null;
//   //   }
//   // }
//   Future<String?> uploadImage(Uint8List imageData, String imageName) async {
//     try {
//       if (imageData.isEmpty) {
//         print("Image data is empty for image: $imageName");
//         return null;
//       }
//
//       print("${imageData}===============================================");
//
//       // Use the imageName to create a unique path
//       final storageRef = FirebaseStorage.instance.ref().child("uploads/$imageName");
//
//       // Upload the image data to the specified path
//       final uploadTask = storageRef.putData(imageData);
//
//       final snapshot = await uploadTask.whenComplete(() {
//         print("Upload complete for: $imageName");
//       });
//
//       // Get the download URL after the upload is complete
//       final downloadUrl = await snapshot.ref.getDownloadURL();
//       print("Download URL for $imageName: $downloadUrl");
//       return downloadUrl;
//     } catch (e) {
//       print("Error uploading image: $e");
//       return null;
//     }
//   }
//   Future<void> uploadSelectedImages() async {
//     List<Uint8List> selectedImageData = [];
//     for (int i = 0; i < images.length; i++) {
//       if (selectedImages[i] && thumbnails[i] != null) {
//         selectedImageData.add(thumbnails[i]!);
//       }
//     }
//
//     List<String> urls = [];
//     for (int i = 0; i < selectedImageData.length; i++) {
//       String? url = await uploadImage(selectedImageData[i], "image_$i.jpg");
//       if (url != null) {
//         urls.add(url);
//       }
//     }
//
//     setState(() {
//       uploadedUrls = urls;
//     });
//   }
//   final uploader = ImageUploader();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Chọn hình ảnh'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.cloud_upload),
//             onPressed: uploadSelectedImages,
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: GridView.builder(
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
//               itemCount: images.length,
//               itemBuilder: (context, index) {
//                 return GestureDetector(
//                   onTap: () => onImageTap(index),
//                   child: Stack(
//                     children: [
//                       // Hiển thị thumbnail từ cache
//                       thumbnails[index] != null
//                           ? Image.memory(thumbnails[index]!, fit: BoxFit.cover, width: double.infinity, height: double.infinity)
//                           : const Center(child: CircularProgressIndicator()),
//                       // Hiển thị checkbox khi ảnh được chọn
//                       // if (selectedImages[index])
//                       Align(
//                         alignment: Alignment.topRight,
//                         child: Container(
//                           margin: const EdgeInsets.only(top: 10, right: 10),
//                           height: 20,
//                           width: 20,
//                           decoration: BoxDecoration(
//                               shape: BoxShape.circle,
//                               color: selectedImages[index] ? Colors.blue : null,
//                               border: Border.all(width: 2.5, color: Colors.white)),
//                           child: selectedImages[index]
//                               ? const Icon(Icons.check, color: Colors.white, size: 16)
//                               : Container(),
//                         ),
//                       ),
//                       // const Positioned(
//                       //   top: 8,
//                       //   right: 8,
//                       //   child: Icon(Icons.check_circle, color: Colors.blue, size: 24),
//                       // ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//           ),
//           if (uploadedUrls.isNotEmpty)
//             Expanded(
//               child: ListView.builder(
//                 itemCount: uploadedUrls.length,
//                 itemBuilder: (context, index) {
//                   return ListTile(
//                     title: Text('Uploaded Image ${index + 1}'),
//                     subtitle: Text(uploadedUrls[index]),
//                     leading: Icon(Icons.image, color: Colors.green),
//                   );
//                 },
//               ),
//             ),
//           TextButton(onPressed: () =>           uploader.uploadImage(),child: Text("data"),)
//         ],
//       ),
//     );
//   }
// }
//
// class ImageUploader {
//   final FirebaseStorage _storage = FirebaseStorage.instance;
//   final ImagePicker _picker = ImagePicker();
//
//   Future<void> uploadImage() async {
//     final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
//
//     if (pickedFile == null) return;
//
//     File imageFile = File(pickedFile.path);
//     String fileName = pickedFile.path.split("/").last;
//
//     try {
//       // Tải ảnh lên Firebase Storage
//       await _storage.ref('uploads/$fileName').putFile(imageFile);
//
//       // Lấy URL của ảnh đã tải lên
//       String downloadURL = await _storage.ref('uploads/$fileName').getDownloadURL();
//       if (kDebugMode) {
//         print("Download URL: $downloadURL");
//       }
//     } catch (e) {
//       if (kDebugMode) {
//         print("Upload failed: $e");
//       }
//     }
//   }
// }
// class UploadImageScreen extends StatefulWidget {
//   const UploadImageScreen({super.key});
//
//   @override
//   _UploadImageScreenState createState() => _UploadImageScreenState();
// }
//
// class _UploadImageScreenState extends State<UploadImageScreen> {
//   final ImagePicker _picker = ImagePicker();
//   String _imageData = "";
//
//   // Hàm chọn ảnh từ thư viện
//   Future<void> _pickImage() async {
//     final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
//     if (image != null) {
//       setState(() {
//         _imageData = image.path;
//       });
//     }
//   }
//
//   // Hàm tải ảnh lên Firebase
//   Future<void> _uploadImage() async {
//     if (_imageData.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Vui lòng chọn ảnh trước khi tải lên')),
//       );
//       return;
//     }
//
//     try {
//       // Tạo một tham chiếu đến Firebase Storage
//       Reference storageRef = FirebaseStorage.instance
//           .ref()
//           .child('uploads/${DateTime.now().millisecondsSinceEpoch}.png');
//
//       // Bắt đầu tải ảnh lên Firebase Storage
//       UploadTask uploadTask = storageRef.putFile(File(_imageData));
//       TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
//       String downloadURL = await taskSnapshot.ref.getDownloadURL();
//
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Tải ảnh thành công! URL: $downloadURL')),
//       );
//     } on FirebaseException catch (e) {
//       print("Failed with error '${e.code}': ${e.message}=============");
//     } catch (e) {
//       print('Lỗi tải ảnh lên Firebase: $e');
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Lỗi tải ảnh lên Firebase')),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Upload Image to Firebase'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             _imageData.isNotEmpty
//                 ? Image.file(File(_imageData))
//                 : const Placeholder(fallbackHeight: 200, fallbackWidth: 200),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _pickImage,
//               child: Text('Chọn ảnh từ thư viện'),
//             ),
//             ElevatedButton(
//               onPressed: _uploadImage,
//               child: Text('Tải ảnh lên Firebase'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class ImageUploaderScreen extends StatefulWidget {
//   const ImageUploaderScreen({super.key});
//
//   @override
//   _ImageUploaderScreenState createState() => _ImageUploaderScreenState();
// }
//
// // class _ImageUploaderScreenState extends State<ImageUploaderScreen> {
// //   Uint8List? _imageData;
// //   final ImagePicker _picker = ImagePicker();
// //
// //   // Hàm yêu cầu quyền truy cập bộ nhớ
// //   Future<bool> requestPermission() async {
// //     final status = await Permission.storage.request();
// //     return status == PermissionStatus.granted;
// //   }
// //
// //   // Hàm chọn ảnh từ thư viện
// //   Future<void> pickImage() async {
// //     if (await requestPermission()) {
// //       final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
// //       if (image != null) {
// //         final Uint8List imageData = await image.readAsBytes();
// //         setState(() {
// //           _imageData = imageData;
// //         });
// //       } else {
// //         print("No image selected");
// //       }
// //     } else {
// //       print("Storage permission not granted");
// //     }
// //   }
// //
// //   // Hàm tải ảnh lên Firebase
// //   Future<String?> uploadImage() async {
// //     if (_imageData == null) return null;
// //
// //     try {
// //       final storageRef = FirebaseStorage.instance
// //           .ref()
// //           .child("uploads/${DateTime.now().millisecondsSinceEpoch}.jpg");
// //       final uploadTask = storageRef.putData(_imageData!);
// //
// //       // Đợi tải lên hoàn tất
// //       final snapshot = await uploadTask.whenComplete(() {});
// //       final downloadUrl = await snapshot.ref.getDownloadURL();
// //       print("Download URL: $downloadUrl");
// //       return downloadUrl;
// //     } catch (e) {
// //       print("Error uploading image: $e");
// //       return null;
// //     }
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text("Upload Image to Firebase"),
// //       ),
// //       body: Column(
// //         mainAxisAlignment: MainAxisAlignment.center,
// //         children: [
// //           _imageData != null
// //               ? Image.memory(_imageData!, height: 200)
// //               : Text("No image selected"),
// //           SizedBox(height: 20),
// //           ElevatedButton(
// //             onPressed: pickImage,
// //             child: Text("Select Image"),
// //           ),
// //           SizedBox(height: 20),
// //           ElevatedButton(
// //             onPressed: () async {
// //               final url = await uploadImage();
// //               if (url != null) {
// //                 ScaffoldMessenger.of(context).showSnackBar(SnackBar(
// //                   content: Text("Image uploaded! URL: $url"),
// //                 ));
// //               }
// //             },
// //             child: Text("Upload Image"),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }
// class _ImageUploaderScreenState extends State<ImageUploaderScreen> {
//   List<AssetEntity> images = [];
//   List<Uint8List?> thumbnails = [];
//   List<bool> selectedImages = [];
//   List<String> uploadedUrls = [];
//
//   @override
//   void initState() {
//     super.initState();
//     loadImages();
//   }
//
//   Future<void> loadImages() async {
//     final albums = await PhotoManager.getAssetPathList(type: RequestType.image);
//     final recentAlbum = albums.first;
//     final recentImages = await recentAlbum.getAssetListRange(start: 0, end: 100);
//
//     // Tải thumbnail và lưu vào cache
//     List<Uint8List?> thumbnailDataList = await Future.wait(
//       recentImages.map((image) => image.thumbnailData).toList(),
//     );
//
//     setState(() {
//       images = recentImages;
//       thumbnails = thumbnailDataList;
//       selectedImages = List<bool>.filled(images.length, false);
//     });
//   }
//
//   void onImageTap(int index) {
//     setState(() {
//       selectedImages[index] = !selectedImages[index];
//     });
//   }
//
//   Future<String?> uploadImage(Uint8List imageData, String imageName) async {
//     try {
//       final storageRef = FirebaseStorage.instance.ref().child("uploads/$imageName");
//       final uploadTask = storageRef.putData(imageData);
//
//       final snapshot = await uploadTask.whenComplete(() {});
//       return await snapshot.ref.getDownloadURL();
//     } catch (e) {
//       print("Error uploading image: $e");
//       return null;
//     }
//   }
//
//   Future<void> uploadSelectedImages() async {
//     List<Uint8List> selectedImageData = [];
//     for (int i = 0; i < images.length; i++) {
//       if (selectedImages[i] && thumbnails[i] != null) {
//         selectedImageData.add(thumbnails[i]!);
//       }
//     }
//
//     List<String> urls = [];
//     for (int i = 0; i < selectedImageData.length; i++) {
//       String? url = await uploadImage(selectedImageData[i], "image_$i.jpg");
//       if (url != null) {
//         urls.add(url);
//       }
//     }
//
//     setState(() {
//       uploadedUrls = urls;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Chọn hình ảnh'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.cloud_upload),
//             onPressed: uploadSelectedImages,
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: GridView.builder(
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
//               itemCount: images.length,
//               itemBuilder: (context, index) {
//                 return GestureDetector(
//                   onTap: () => onImageTap(index),
//                   child: Stack(
//                     children: [
//                       thumbnails[index] != null
//                           ? Image.memory(thumbnails[index]!, fit: BoxFit.cover)
//                           : const Center(child: CircularProgressIndicator()),
//                       if (selectedImages[index])
//                         const Positioned(
//                           top: 8,
//                           right: 8,
//                           child: Icon(Icons.check_circle, color: Colors.blue),
//                         ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//           ),
//           if (uploadedUrls.isNotEmpty)
//             Expanded(
//               child: ListView.builder(
//                 itemCount: uploadedUrls.length,
//                 itemBuilder: (context, index) {
//                   return ListTile(
//                     title: Text('Uploaded Image ${index + 1}'),
//                     subtitle: Text(uploadedUrls[index]),
//                   );
//                 },
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }
