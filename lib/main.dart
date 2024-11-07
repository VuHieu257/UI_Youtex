import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';
import 'package:photo_manager/photo_manager.dart';
import 'package:ui_youtex/bloc_seller/bloc/bloc_seller_address_bloc.dart';
import 'package:ui_youtex/bloc_seller/bloc_seller_register_status_bloc.dart/seller_register_status_bloc.dart';
import 'package:ui_youtex/bloc_seller/seller_register_identification_bloc/seller_register_identification_bloc_bloc.dart';
import 'package:ui_youtex/bloc_seller/seller_register_bloc/seller_register_event.dart';
import 'package:ui_youtex/bloc_seller/seller_register_product_bloc_bloc/seller_register_product_bloc_bloc.dart';
import 'package:ui_youtex/bloc_seller/seller_register_tax_get_bloc/seller_register_tax_get_bloc_bloc.dart';
import 'package:ui_youtex/core/model/store.info.dart';

import 'dart:core';
import 'package:ui_youtex/pages/screens/home/home.dart';
import 'package:ui_youtex/pages/screens/mall/user_mail/user_mail_shop_product.dart';
import 'package:ui_youtex/pages/screens/member_Vip/free_trail.dart';
import 'package:ui_youtex/pages/screens/member_Vip/member_packagePayment.dart';
import 'package:ui_youtex/pages/screens/shopping_cart_page/payment_method_screen/payment_method_screen%20copy.dart';
import 'package:ui_youtex/pages/screens/shopping_cart_page/payment_method_screen/payment_method_screen.dart';
import 'package:ui_youtex/pages/splash/Welcome/Register/RegisterScreen.dart';
import 'package:ui_youtex/pages/splash/Welcome/Register/resetPass/forgotPass_Screen.dart';
import 'package:ui_youtex/pages/splash/Welcome/Register/resetPass/resetPassDone_screen.dart';
import 'package:ui_youtex/pages/splash/Welcome/Register/resetPass/resetPassOtp_screen.dart';
import 'package:ui_youtex/pages/splash/Welcome/Register/resetPass/resetPass_screen.dart';
import 'package:ui_youtex/pages/widget_small/bottom_navigation/bottom_navigation.dart';
import 'package:ui_youtex/services/restful_api_provider.dart';
import 'bloc/login_bloc/login_bloc.dart';
import 'bloc_seller/seller_register_bloc/seller_register_bloc.dart';
import 'core/themes/theme_data.dart';
import 'pages/splash/Welcome/Register/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
              apiKey: 'AIzaSyCU66WlqitlSdBipwdwb_69uuRnJNupI0s',
              appId: '1:57983356211:android:5fd331cd4ef5361fea4246',
              messagingSenderId: '57983356211',
              projectId: 'mangxahoi-sotavn',
              storageBucket: "mangxahoi-sotavn.appspot.com"))
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
            create: (context) => LoginBloc(),
          ),
          BlocProvider(
            create: (context) => SellerAddressBloc(
              restfulApiProvider: apiProvider,
            ),
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

      home: BlocProvider(
        create: (context) => SellerRegisterBloc(
          restfulApiProvider: RestfulApiProviderImpl(),
        ),
        child: CustomNavBar(),
        // child: AddressScreen(),
      ), // home: const CustomNavBar(),
      // home: const RegisterMallScreen(),
      // home: const MessagesScreen(),
      // home: const GridGallery(),
      // home: CustomBackground(),
      // home: MembershipPaymentScreen(),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/home': (context) => const HomePage(),
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

class GridGallery extends StatefulWidget {
  final ScrollController? scrollCtr;

  const GridGallery({super.key, this.scrollCtr});

  @override
  _GridGalleryState createState() => _GridGalleryState();
}

class _GridGalleryState extends State<GridGallery> {
  final List<AssetEntity> _mediaList = []; // Store images directly
  List<Widget> _confirmedImages = []; // Confirmed images for display
  int currentPage = 0;
  int? lastPage;
  final Set<AssetEntity> _selectedImages = {};

  @override
  void initState() {
    super.initState();
    _fetchNewMedia();
  }

  _handleScrollEvent(ScrollNotification scroll) {
    if (scroll.metrics.pixels / scroll.metrics.maxScrollExtent > 0.33) {
      if (currentPage != lastPage) {
        _fetchNewMedia();
      }
    }
  }

  _fetchNewMedia() async {
    lastPage = currentPage;
    final PermissionState ps = await PhotoManager.requestPermissionExtend();

    if (ps.isAuth) {
      List<AssetPathEntity> albums = await PhotoManager.getAssetPathList(
        type: RequestType.image,
        onlyAll: true,
      );

      if (albums.isNotEmpty) {
        List<AssetEntity> media = await albums[0].getAssetListPaged(
          page: currentPage,
          size: 60,
        );

        setState(() {
          _mediaList.addAll(media); // Add new images to the list
          currentPage++;
        });
      }
    } else {
      PhotoManager.openSetting();
    }
  }

  // Confirm selected images to display on main screen
  void _confirmSelection() async {
    List<Widget> selectedWidgets = _selectedImages.map((asset) {
      return FutureBuilder<Uint8List?>(
        future: asset.thumbnailDataWithSize(const ThumbnailSize(200, 200)),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.data != null) {
            return Image.memory(snapshot.data!, fit: BoxFit.cover);
          }
          return Container(color: Colors.grey);
        },
      );
    }).toList();

    setState(() {
      _confirmedImages = selectedWidgets;
      _selectedImages.clear(); // Clear selection after confirmation
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Display confirmed images at the top
          if (_confirmedImages.isNotEmpty)
            Expanded(
              child: GridView.count(
                crossAxisCount: 3,
                children: _confirmedImages,
              ),
            ),
          Expanded(
            child: NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scroll) {
                _handleScrollEvent(scroll);
                return false;
              },
              child: GridView.builder(
                controller: widget.scrollCtr,
                itemCount: _mediaList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemBuilder: (context, index) {
                  AssetEntity asset = _mediaList[index];
                  bool isSelected = _selectedImages.contains(asset);

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isSelected) {
                          _selectedImages.remove(asset);
                        } else {
                          _selectedImages.add(asset);
                        }
                      });
                    },
                    child: Stack(
                      children: [
                        FutureBuilder<Uint8List?>(
                          future: asset.thumbnailDataWithSize(
                              const ThumbnailSize(200, 200)),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                    ConnectionState.done &&
                                snapshot.data != null) {
                              return Positioned.fill(
                                child: Image.memory(
                                  snapshot.data!,
                                  fit: BoxFit.cover,
                                ),
                              );
                            }
                            return Container(color: Colors.grey);
                          },
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            margin: const EdgeInsets.only(top: 10, right: 10),
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: isSelected ? Colors.blue : null,
                                border: Border.all(
                                    width: 2.5, color: Colors.white)),
                            child: isSelected
                                ? const Icon(Icons.check,
                                    color: Colors.white, size: 16)
                                : Container(),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          ElevatedButton(
            onPressed: _selectedImages.isNotEmpty ? _confirmSelection : null,
            child: const Text('Confirm Selection'),
          ),
        ],
      ),
    );
  }
}

// class SellerRegisterScreen extends StatefulWidget {
//   @override
//   _SellerRegisterScreenState createState() => _SellerRegisterScreenState();
// }

// class _SellerRegisterScreenState extends State<SellerRegisterScreen> {
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _phoneController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   String? _imagePath;
//   final ImagePicker _picker = ImagePicker();

//   @override
//   void initState() {
//     super.initState();
//     // Gửi sự kiện để tải thông tin cửa hàng khi màn hình khởi động
//     context.read<SellerRegisterBloc>().add(LoadStoreInfo());
//   }

//   @override
//   void dispose() {
//     _nameController.dispose();
//     _phoneController.dispose();
//     _emailController.dispose();
//     super.dispose();
//   }

//   Future<void> _pickImage() async {
//     try {
//       final XFile? pickedFile = await _picker.pickImage(
//         source: ImageSource.gallery,
//         maxWidth: 1800,
//         maxHeight: 1800,
//         imageQuality: 85,
//       );

//       if (pickedFile != null) {
//         setState(() {
//           _imagePath = pickedFile.path;
//         });
//       }
//     } catch (e) {
//       _showError('Error picking image: ${e.toString()}');
//     }
//   }

//   void _showError(String message) {
//     if (!mounted) return;
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//         backgroundColor: Colors.red,
//         duration: Duration(seconds: 3),
//       ),
//     );
//   }

//   void _showSuccess(String message) {
//     if (!mounted) return;
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text(message), backgroundColor: Colors.green),
//     );
//   }

//   bool _validateInputs() {
//     if (_nameController.text.isEmpty) {
//       _showError('Vui lòng nhập tên cửa hàng');
//       return false;
//     }
//     if (_phoneController.text.isEmpty) {
//       _showError('Vui lòng nhập số điện thoại');
//       return false;
//     }
//     if (_emailController.text.isEmpty) {
//       _showError('Vui lòng nhập email');
//       return false;
//     }
//     if (_imagePath == null) {
//       _showError('Vui lòng chọn ảnh cửa hàng');
//       return false;
//     }
//     return true;
//   }

//   void _updateFormData(StoreInfo data) {
//     print(
//         "Updating form data: Name: ${data.name}, Phone: ${data.phone}, Email: ${data.email}, ImagePath: ${data.imagePath}");
//     _nameController.text = data.name;
//     _phoneController.text = data.phone;
//     _emailController.text = data.email;
//     setState(() {
//       _imagePath = data.imagePath;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Thông tin cửa hàng'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.refresh),
//             onPressed: () {
//               context.read<SellerRegisterBloc>().add(LoadStoreInfo());
//             },
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: BlocConsumer<SellerRegisterBloc, SellerRegisterState>(
//             listener: (context, state) {
//               if (state is SellerRegisterSuccess) {
//                 _showSuccess('Cập nhật thông tin thành công!');
//               } else if (state is SellerRegisterFailure) {
//                 _showError(state.error);
//               } else if (state is SellerRegisterLoaded) {
//                 _updateFormData(state.storeInfo); // Đảm bảo đây là StoreInfo
//                 _showSuccess('Đã tải thông tin cửa hàng');
//               }
//             },
//             builder: (context, state) {
//               if (state is SellerRegisterLoading) {
//                 return Center(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       CircularProgressIndicator(),
//                       SizedBox(height: 16),
//                       Text('Đang tải thông tin...'),
//                     ],
//                   ),
//                 );
//               }

//               return Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   TextField(
//                     controller: _nameController,
//                     decoration: InputDecoration(
//                       labelText: 'Tên cửa hàng',
//                       border: OutlineInputBorder(),
//                       prefixIcon: Icon(Icons.store),
//                     ),
//                   ),
//                   SizedBox(height: 16),
//                   TextField(
//                     controller: _phoneController,
//                     keyboardType: TextInputType.phone,
//                     decoration: InputDecoration(
//                       labelText: 'Số điện thoại',
//                       border: OutlineInputBorder(),
//                       prefixIcon: Icon(Icons.phone),
//                     ),
//                   ),
//                   SizedBox(height: 16),
//                   TextField(
//                     controller: _emailController,
//                     keyboardType: TextInputType.emailAddress,
//                     decoration: InputDecoration(
//                       labelText: 'Email',
//                       border: OutlineInputBorder(),
//                       prefixIcon: Icon(Icons.email),
//                     ),
//                   ),
//                   SizedBox(height: 24),
//                   ElevatedButton.icon(
//                     onPressed: _pickImage,
//                     icon: Icon(Icons.image),
//                     label: Text('Chọn ảnh cửa hàng'),
//                     style: ElevatedButton.styleFrom(
//                       padding: EdgeInsets.symmetric(vertical: 12),
//                     ),
//                   ),
//                   if (_imagePath != null) ...[
//                     SizedBox(height: 16),
//                     ClipRRect(
//                       borderRadius: BorderRadius.circular(8),
//                       child: _imagePath!.startsWith('http')
//                           ? Image.network(
//                               _imagePath!,
//                               width: 150,
//                               height: 150,
//                               fit: BoxFit.cover,
//                             )
//                           : Image.file(
//                               File(_imagePath!),
//                               width: 150,
//                               height: 150,
//                               fit: BoxFit.cover,
//                             ),
//                     ),
//                   ],
//                   SizedBox(height: 24),
//                   ElevatedButton(
//                     onPressed: () {
//                       if (_validateInputs()) {
//                         context.read<SellerRegisterBloc>().add(
//                               SellerRegisterButtonPressed(
//                                 name: _nameController.text,
//                                 phone: _phoneController.text,
//                                 email: _emailController.text,
//                                 imagePath: _imagePath!,
//                               ),
//                             );
//                       }
//                     },
//                     style: ElevatedButton.styleFrom(
//                       padding: EdgeInsets.symmetric(vertical: 16),
//                       backgroundColor: Theme.of(context).primaryColor,
//                     ),
//                     child: Text(
//                       'Cập nhật thông tin',
//                       style: TextStyle(fontSize: 16),
//                     ),
//                   ),
//                 ],
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }import 'package:flutter/material.dart';

// class AddressScreen extends StatefulWidget {
//   @override
//   _AddressScreenState createState() => _AddressScreenState();
// }

// class _AddressScreenState extends State<AddressScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _nameController = TextEditingController();
//   final _phoneController = TextEditingController();
//   final _countryController = TextEditingController();
//   final _provinceController = TextEditingController();
//   final _wardController = TextEditingController();
//   final _addressController = TextEditingController();
//   final _longitudeController = TextEditingController();
//   final _latitudeController = TextEditingController();
//   bool _isDefault = false;

//   @override
//   void dispose() {
//     _nameController.dispose();
//     _phoneController.dispose();
//     _countryController.dispose();
//     _provinceController.dispose();
//     _wardController.dispose();
//     _addressController.dispose();
//     _longitudeController.dispose();
//     _latitudeController.dispose();
//     super.dispose();
//   }

//   void _submitForm() {
//     if (_formKey.currentState?.validate() ?? false) {
//       context.read<SellerRegisterAddressBloc>().add(
//             SellerRegisterAddressSubmitted(
//               name: _nameController.text,
//               phone: _phoneController.text,
//               country: _countryController.text,
//               province: _provinceController.text,
//               ward: _wardController.text,
//               address: _addressController.text,
//               longitude: _longitudeController.text,
//               latitude: _latitudeController.text,
//               isDefault: _isDefault,
//             ),
//           );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Address Information'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.location_on),
//             onPressed: () {
//               context
//                   .read<SellerRegisterAddressGetBlocBloc>()
//                   .add(FetchAddressEvent());
//             },
//           ),
//         ],
//       ),
//       body: BlocListener<SellerRegisterAddressBloc, SellerRegisterAddressState>(
//         listener: (context, state) {
//           if (state is SellerRegisterAddressSuccess) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               const SnackBar(content: Text('Address saved successfully')),
//             );
//           } else if (state is SellerRegisterAddressFailure) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(content: Text('Error: ${state.error}')),
//             );
//           }
//         },
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(16),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 BlocBuilder<SellerRegisterAddressGetBlocBloc,
//                     SellerRegisterAddressGetBlocState>(
//                   builder: (context, state) {
//                     if (state is SellerRegisterAddressLoaded) {
//                       // Auto-fill form fields with fetched data
//                       // You'll need to modify this based on your actual data structure
//                       return Card(
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Text('Fetched Address: ${state.data}'),
//                         ),
//                       );
//                     } else if (state is SellerRegisterAddressError) {
//                       return Card(
//                         color: Colors.red[100],
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Text('Error: ${state.errorMessage}'),
//                         ),
//                       );
//                     }
//                     return const SizedBox.shrink();
//                   },
//                 ),
//                 const SizedBox(height: 16),
//                 TextFormField(
//                   controller: _nameController,
//                   decoration: const InputDecoration(
//                     labelText: 'Name',
//                     border: OutlineInputBorder(),
//                   ),
//                   validator: (value) {
//                     if (value?.isEmpty ?? true) return 'Please enter a name';
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 16),
//                 TextFormField(
//                   controller: _phoneController,
//                   decoration: const InputDecoration(
//                     labelText: 'Phone',
//                     border: OutlineInputBorder(),
//                   ),
//                   validator: (value) {
//                     if (value?.isEmpty ?? true)
//                       return 'Please enter a phone number';
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 16),
//                 TextFormField(
//                   controller: _countryController,
//                   decoration: const InputDecoration(
//                     labelText: 'Country',
//                     border: OutlineInputBorder(),
//                   ),
//                   validator: (value) {
//                     if (value?.isEmpty ?? true) return 'Please enter a country';
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 16),
//                 TextFormField(
//                   controller: _provinceController,
//                   decoration: const InputDecoration(
//                     labelText: 'Province',
//                     border: OutlineInputBorder(),
//                   ),
//                   validator: (value) {
//                     if (value?.isEmpty ?? true)
//                       return 'Please enter a province';
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 16),
//                 TextFormField(
//                   controller: _wardController,
//                   decoration: const InputDecoration(
//                     labelText: 'Ward',
//                     border: OutlineInputBorder(),
//                   ),
//                   validator: (value) {
//                     if (value?.isEmpty ?? true) return 'Please enter a ward';
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 16),
//                 TextFormField(
//                   controller: _addressController,
//                   decoration: const InputDecoration(
//                     labelText: 'Address',
//                     border: OutlineInputBorder(),
//                   ),
//                   validator: (value) {
//                     if (value?.isEmpty ?? true)
//                       return 'Please enter an address';
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 16),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: TextFormField(
//                         controller: _longitudeController,
//                         decoration: const InputDecoration(
//                           labelText: 'Longitude',
//                           border: OutlineInputBorder(),
//                         ),
//                         validator: (value) {
//                           if (value?.isEmpty ?? true)
//                             return 'Please enter longitude';
//                           return null;
//                         },
//                       ),
//                     ),
//                     const SizedBox(width: 16),
//                     Expanded(
//                       child: TextFormField(
//                         controller: _latitudeController,
//                         decoration: const InputDecoration(
//                           labelText: 'Latitude',
//                           border: OutlineInputBorder(),
//                         ),
//                         validator: (value) {
//                           if (value?.isEmpty ?? true)
//                             return 'Please enter latitude';
//                           return null;
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 16),
//                 CheckboxListTile(
//                   title: const Text('Set as default address'),
//                   value: _isDefault,
//                   onChanged: (value) {
//                     setState(() {
//                       _isDefault = value ?? false;
//                     });
//                   },
//                 ),
//                 const SizedBox(height: 24),
//                 BlocBuilder<SellerRegisterAddressBloc,
//                     SellerRegisterAddressState>(
//                   builder: (context, state) {
//                     return ElevatedButton(
//                       onPressed: _submitForm,
//                       child: const Text('Save Address'),
//                     );
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
// class SellerRegisterTaxScreen extends StatefulWidget {
//   @override
//   _SellerRegisterTaxScreenState createState() =>
//       _SellerRegisterTaxScreenState();
// }

// class _SellerRegisterTaxScreenState extends State<SellerRegisterTaxScreen> {
//   File? _selectedImage; // Biến lưu ảnh đã chọn
//   final ImagePicker _picker = ImagePicker(); // Khởi tạo image picker

//   // Hàm chọn ảnh từ thư viện hoặc chụp ảnh từ máy ảnh
//   Future<void> _pickImage() async {
//     final pickedFile = await _picker.pickImage(
//         source: ImageSource.gallery); // Hoặc ImageSource.camera để chụp ảnh
//     if (pickedFile != null) {
//       setState(() {
//         _selectedImage =
//             File(pickedFile.path); // Lưu ảnh vào biến _selectedImage
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final taxBloc = context.read<SellerRegisterTaxBloc>();
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Thông tin thuế'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             ElevatedButton(
//               onPressed: _pickImage, // Gọi hàm chọn ảnh
//               child: Text('Chọn ảnh giấy phép kinh doanh'),
//             ),
//             if (_selectedImage != null)
//               Image.file(
//                 _selectedImage!,
//                 height: 200,
//               ),
//             ElevatedButton(
//               onPressed: () {
//                 // Nếu có ảnh đã chọn thì gửi yêu cầu
//                 if (_selectedImage != null) {
//                   final taxModel = SellerRegisterTaxModel(
//                     type: "personal",
//                     address: "123 Business St",
//                     email: "business@example.com",
//                     taxCode: "TAX123456",
//                     name: "Test Business",
//                     businessLicense: _selectedImage!.path,
//                   );
//                   taxBloc.add(SellerRegisterTaxPostBlocEvent(model: taxModel));
//                 } else {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(content: Text('Vui lòng chọn ảnh trước khi gửi')),
//                   );
//                 }
//               },
//               child: Text('Gửi thông tin thuế'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class SellerRegisterIdentificationScreen extends StatefulWidget {
//   @override
//   _SellerRegisterIdentificationScreenState createState() =>
//       _SellerRegisterIdentificationScreenState();
// }

// class _SellerRegisterIdentificationScreenState
//     extends State<SellerRegisterIdentificationScreen> {
//   File? _selectedImage; // Biến lưu ảnh đã chọn
//   final ImagePicker _picker = ImagePicker(); // Khởi tạo image picker

//   // Hàm chọn ảnh từ thư viện hoặc chụp ảnh từ máy ảnh
//   Future<void> _pickImage() async {
//     final pickedFile = await _picker.pickImage(
//         source: ImageSource.gallery); // Hoặc ImageSource.camera để chụp ảnh
//     if (pickedFile != null) {
//       setState(() {
//         _selectedImage =
//             File(pickedFile.path); // Lưu ảnh vào biến _selectedImage
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final taxBloc = context.read<SellerRegisterTaxBloc>();
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Thông tin thuế'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             ElevatedButton(
//               onPressed: _pickImage, // Gọi hàm chọn ảnh
//               child: Text('Chọn ảnh giấy phép kinh doanh'),
//             ),
//             if (_selectedImage != null)
//               Image.file(
//                 _selectedImage!,
//                 height: 200,
//               ),
//             ElevatedButton(
//               onPressed: () {
//                 // Nếu có ảnh đã chọn thì gửi yêu cầu
//                 if (_selectedImage != null) {
//                   final taxModel = SellerIdentificationModel(
//                     type: "personal",
//                     address: "123 Business St",
//                     email: "business@example.com",
//                     taxCode: "TAX123456",
//                     name: "Test Business",
//                     businessLicense: _selectedImage!.path,
//                   );
//                   taxBloc.add(SellerRegisterTaxPostBlocEvent(model: taxModel));
//                 } else {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(content: Text('Vui lòng chọn ảnh trước khi gửi')),
//                   );
//                 }
//               },
//               child: Text('Gửi thông tin thuế'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
