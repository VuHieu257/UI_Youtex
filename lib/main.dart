import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'package:ui_youtex/bloc/address_bloc/address_bloc.dart';
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
import 'package:ui_youtex/pages/screens/user/add_address_screen/add_address_screen.dart';
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

      // home: const WelcomeApp(),
      // home: const CustomNavBar(),
      home: const AddressScreenUser(),
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
