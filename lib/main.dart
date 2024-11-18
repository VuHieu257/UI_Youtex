import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:ui_youtex/bloc/address_bloc/address_bloc.dart';
import 'package:ui_youtex/bloc/cart_bloc/cart_bloc.dart';
import 'package:ui_youtex/bloc/cart_checkout_bloc/bloc/checkout_bloc.dart';
import 'package:ui_youtex/bloc/cart_checkout_bloc/bloc/checkout_event.dart';
import 'package:ui_youtex/bloc/cart_checkout_bloc/bloc/checkout_state.dart';
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
import 'package:ui_youtex/pages/screens/shopping_cart_page/checkout_page/checkout_page.dart';
import 'package:ui_youtex/pages/screens/shopping_cart_page/payment_method_screen/payment_method_screen%20copy.dart';
import 'package:ui_youtex/pages/screens/shopping_cart_page/payment_method_screen/payment_method_screen.dart';
import 'package:ui_youtex/pages/screens/voucher/Voucher_seller.dart';
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
          // options: const FirebaseOptions(
          //     apiKey: 'AIzaSyCU66WlqitlSdBipwdwb_69uuRnJNupI0s',
          //     appId: '1:57983356211:android:5fd331cd4ef5361fea4246',
          //     messagingSenderId: '57983356211',
          //     projectId: 'mangxahoi-sotavn',
          //     storageBucket: "mangxahoi-sotavn.appspot.com"))
          options: const FirebaseOptions(
              apiKey: 'AIzaSyAa58C3JobxigKYnj-kfdDztCOZc-ycCQE',
              appId: '1:966122516663:android:670e20e49319be6a325d32',
              messagingSenderId: '966122516663',
              projectId: 'b-idea-b5e02',
              storageBucket: "b-idea-b5e02.appspot.com"))
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
            create: (context) => AddressBloc(),
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
//
      // home: const CheckoutPage(),
      home: const CustomNavBar(),
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
        '/discountCodeScreen': (context) => const VoucherSlScreen(),
      },
    );
  }
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  List<XFile> _selectedImages = [];

  // Hàm chọn nhiều ảnh
  Future<void> _pickImages() async {
    final List<XFile>? selectedImages = await _picker.pickMultiImage();
    if (selectedImages != null) {
      setState(() {
        _selectedImages = selectedImages;
      });
    }
  }

  // Hàm gửi tin nhắn và ảnh
  void _sendMessage() async {
    String message = _messageController.text.trim();
    _messageController.clear();

    if (message.isEmpty && _selectedImages.isEmpty) return;

    // Xử lý gửi tin nhắn lên Firestore
    // Upload ảnh lên Firebase Storage và thêm URL ảnh vào Firestore

    setState(() {
      _selectedImages = []; // Xoá ảnh sau khi gửi
    });
  }

  // Hàm xoá một ảnh khỏi danh sách
  void _removeImage(int index) {
    setState(() {
      _selectedImages.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Hiển thị các ảnh đã chọn
          if (_selectedImages.isNotEmpty)
            SizedBox(
              height: 100,
              child: GridView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _selectedImages.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  mainAxisSpacing: 8,
                ),
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      Image.file(
                        File(_selectedImages[index].path),
                        fit: BoxFit.cover,
                        width: 100,
                        height: 100,
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: IconButton(
                          icon: Icon(Icons.close, color: Colors.red),
                          onPressed: () => _removeImage(index),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),

          // Trường nhập tin nhắn và các nút
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.image),
                onPressed: _pickImages,
              ),
              Expanded(
                child: TextField(
                  controller: _messageController,
                  decoration:
                      const InputDecoration(labelText: 'Nhập tin nhắn...'),
                ),
              ),
              IconButton(
                icon: Icon(Icons.send),
                onPressed: _sendMessage,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// class CheckoutScreen extends StatelessWidget {
//   const CheckoutScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => CheckoutBloc(restfulApiProvider),
//       child: const CheckoutView(),
//     );
//   }
// }

// class CheckoutView extends StatelessWidget {
//   const CheckoutView({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final bloc = BlocProvider.of<CheckoutBloc>(context);
//     final currencyFormat = NumberFormat.currency(locale: 'vi_VN', symbol: '₫');

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Thanh Toán',
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//         centerTitle: true,
//         elevation: 0,
//       ),
//       body: BlocBuilder<CheckoutBloc, CheckoutState>(
//         builder: (context, state) {
//           if (state is CheckoutInitial) {
//             bloc.add(FetchCheckoutEvent());
//             return const Center(child: CircularProgressIndicator());
//           } else if (state is CheckoutLoading) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (state is CheckoutLoaded) {
//             final checkout = state.checkoutResponse;
//             return Column(
//               children: [
//                 Expanded(
//                   child: ListView.builder(
//                     padding: const EdgeInsets.all(16),
//                     itemCount: checkout.stores.length,
//                     itemBuilder: (context, storeIndex) {
//                       final store = checkout.stores[storeIndex];
//                       return Card(
//                         margin: const EdgeInsets.only(bottom: 16),
//                         elevation: 2,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             // Store Header
//                             ListTile(
//                               leading: CircleAvatar(
//                                 backgroundImage: NetworkImage(store.image),
//                                 backgroundColor: Colors.grey[200],
//                               ),
//                               title: Text(
//                                 store.name,
//                                 style: const TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 16,
//                                 ),
//                               ),
//                               trailing: const Icon(Icons.chevron_right),
//                             ),
//                             const Divider(),

//                             // Products List
//                             ListView.builder(
//                               shrinkWrap: true,
//                               physics: const NeverScrollableScrollPhysics(),
//                               itemCount: store.products.length,
//                               itemBuilder: (context, productIndex) {
//                                 final product = store.products[productIndex];
//                                 return Padding(
//                                   padding: const EdgeInsets.all(12),
//                                   child: Row(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       // Product Image
//                                       ClipRRect(
//                                         borderRadius: BorderRadius.circular(8),
//                                         child: Image.asset(
//                                           // product.image,
//                                           'assets/images/1523107190ffd3b67f393f0636a7ecc7.jpg',
//                                           width: 80,
//                                           height: 80,
//                                           fit: BoxFit.cover,
//                                         ),
//                                       ),
//                                       const SizedBox(width: 12),

//                                       // Product Details
//                                       Expanded(
//                                         child: Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             Text(
//                                               product.name,
//                                               style: const TextStyle(
//                                                 fontSize: 15,
//                                                 fontWeight: FontWeight.w500,
//                                               ),
//                                             ),
//                                             if (product.size != null ||
//                                                 product.color != null)
//                                               Padding(
//                                                 padding: const EdgeInsets.only(
//                                                     top: 4),
//                                                 child: Text(
//                                                   'Phân loại: ${[
//                                                     if (product.size != null)
//                                                       'Size ${product.size}',
//                                                     if (product.color != null)
//                                                       'Màu ${product.color}',
//                                                   ].join(", ")}',
//                                                   style: TextStyle(
//                                                     color: Colors.grey[600],
//                                                     fontSize: 13,
//                                                   ),
//                                                 ),
//                                               ),
//                                             const SizedBox(height: 8),
//                                             Row(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment
//                                                       .spaceBetween,
//                                               children: [
//                                                 Text(
//                                                   currencyFormat.format(
//                                                       product.discountPrice),
//                                                   style: const TextStyle(
//                                                     color: Colors.red,
//                                                     fontWeight: FontWeight.bold,
//                                                     fontSize: 15,
//                                                   ),
//                                                 ),
//                                                 Text(
//                                                   'x${product.quantity}',
//                                                   style: const TextStyle(
//                                                     fontSize: 14,
//                                                     color: Colors.grey,
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 );
//                               },
//                             ),

//                             // Store Total
//                             Container(
//                               padding: const EdgeInsets.all(16),
//                               decoration: BoxDecoration(
//                                 color: Colors.grey[50],
//                                 borderRadius: const BorderRadius.only(
//                                   bottomLeft: Radius.circular(12),
//                                   bottomRight: Radius.circular(12),
//                                 ),
//                               ),
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Text(
//                                     '${store.quantity} sản phẩm',
//                                     style: TextStyle(
//                                       color: Colors.grey[600],
//                                       fontSize: 14,
//                                     ),
//                                   ),
//                                   Text(
//                                     'Tổng: ${currencyFormat.format(store.total)}',
//                                     style: const TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 16,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       );
//                     },
//                   ),
//                 ),

//                 // Bottom Payment Summary
//                 Container(
//                   padding: EdgeInsets.only(
//                     left: 16,
//                     right: 16,
//                     top: 16,
//                     bottom: MediaQuery.of(context).padding.bottom + 16,
//                   ),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.05),
//                         blurRadius: 10,
//                         offset: const Offset(0, -5),
//                       ),
//                     ],
//                   ),
//                   child: SafeArea(
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             const Text(
//                               'Tổng thanh toán',
//                               style: TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                             Text(
//                               currencyFormat.format(checkout.total),
//                               style: const TextStyle(
//                                 color: Colors.red,
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 16),
//                         SizedBox(
//                           width: double.infinity,
//                           height: 48,
//                           child: ElevatedButton(
//                             onPressed: () {
//                               // Handle payment
//                             },
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Colors.red,
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                             ),
//                             child: const Text(
//                               'Đặt Hàng',
//                               style: TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             );
//           } else if (state is CheckoutError) {
//             return Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Icon(
//                     Icons.error_outline,
//                     color: Colors.red,
//                     size: 48,
//                   ),
//                   const SizedBox(height: 16),
//                   Text(
//                     state.message,
//                     style: const TextStyle(color: Colors.red),
//                     textAlign: TextAlign.center,
//                   ),
//                   const SizedBox(height: 16),
//                   ElevatedButton(
//                     onPressed: () {
//                       bloc.add(FetchCheckoutEvent());
//                     },
//                     child: const Text('Thử lại'),
//                   ),
//                 ],
//               ),
//             );
//           }
//           return const SizedBox();
//         },
//       ),
//     );
//   }
// }
