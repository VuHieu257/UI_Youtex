import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:typed_data';
import 'package:photo_manager/photo_manager.dart';
import 'package:ui_youtex/bloc/address_bloc/address_bloc.dart';
import 'dart:core';
import 'package:ui_youtex/pages/screens/home/home.dart';
import 'package:ui_youtex/pages/screens/home/product/adress/adress_screen.dart';
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
import 'bloc/edit_profile_bloc/edit_profile_bloc.dart';
import 'bloc/login_bloc/login_bloc.dart';
import 'bloc/register/register_bloc.dart';
import 'bloc/user_profile_bloc/user_profile_bloc.dart';
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
  runApp(MultiBlocProvider(providers: [
    BlocProvider(
      create: (context) => LoginBloc(),
    ),
    BlocProvider(
      create: (context) => RegisterBloc(),
    ),
    BlocProvider(
      create: (context) => EditProfileBloc(),
    ),
    BlocProvider(
      create: (context) => AddressBloc(),
    ),
    BlocProvider(
      create: (context) => UserProfileBloc()..add(FetchProfileEvent()),
    ),
  ], child: const MyApp()));
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
      // home: const EditProfileScreen(),
      // home: const CustomNavBar(),
      home: const AddressScreen(),
      // home: const MessagesScreen(),
      // home: const GridGallery(),
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

// class AddressScreen extends StatelessWidget {
//   const AddressScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Address List')),
//       body: BlocProvider(
//         create: (context) => AddressBloc()..add(FetchAddresses()),
//         child: BlocBuilder<AddressBloc, AddressState>(
//           builder: (context, state) {
//             if (state is AddressLoading) {
//               return const Center(child: CircularProgressIndicator());
//             } else if (state is AddressLoaded) {
//               return ListView.builder(
//                 itemCount: state.addresses.length,
//                 itemBuilder: (context, index) {
//                   final address = state.addresses[index];
//                   return ListTile(
//                     title: Text(address.name),
//                     subtitle: Text(address.address),
//                     trailing: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         IconButton(
//                           icon: const Icon(Icons.edit),
//                           onPressed: () {
//
//                           },
//                         ),
//                         IconButton(
//                           icon: const Icon(Icons.delete),
//                           onPressed: () {
//                             context
//                                 .read<AddressBloc>()
//                                 .add(DeleteAddress(address.id));
//                           },
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//               );
//             } else if (state is AddressError) {
//               return Center(child: Text(state.message));
//             }
//             return const Center(child: Text('No addresses found.'));
//           },
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//         },
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }

// class GridGallery extends StatefulWidget {
//   final ScrollController? scrollCtr;
//
//   const GridGallery({super.key, this.scrollCtr});
//
//   @override
//   _GridGalleryState createState() => _GridGalleryState();
// }
//
// class _GridGalleryState extends State<GridGallery> {
//   List<Widget> _mediaList = [];
//   List<Widget> _confirmedImages = []; // List to display confirmed images
//   int currentPage = 0;
//   int? lastPage;
//   Set<AssetEntity> _selectedImages = {};
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchNewMedia();
//   }
//
//   _handleScrollEvent(ScrollNotification scroll) {
//     if (scroll.metrics.pixels / scroll.metrics.maxScrollExtent > 0.33) {
//       if (currentPage != lastPage) {
//         _fetchNewMedia();
//       }
//     }
//   }
//
//   _fetchNewMedia() async {
//     lastPage = currentPage;
//     final PermissionState _ps = await PhotoManager.requestPermissionExtend();
//
//     if (_ps.isAuth) {
//       List<AssetPathEntity> albums = await PhotoManager.getAssetPathList(
//         type: RequestType.image,
//         onlyAll: true,
//       );
//
//       if (albums.isNotEmpty) {
//         List<AssetEntity> media = await albums[0].getAssetListPaged(
//           page: currentPage,
//           size: 60,
//         );
//
//         List<Widget> temp = media.map((asset) {
//           return GestureDetector(
//             onTap: () {
//               setState(() {
//                 if (_selectedImages.contains(asset)) {
//                   _selectedImages.remove(asset);
//                 } else {
//                   _selectedImages.add(asset);
//                 }
//               });
//             },
//             child: Stack(
//               children: [
//                 FutureBuilder<Uint8List?>(
//                   future: asset.thumbnailDataWithSize(const ThumbnailSize(200, 200)),
//                   builder: (context, snapshot) {
//                     if (snapshot.connectionState == ConnectionState.done && snapshot.data != null) {
//                       return Positioned.fill(
//                         child: Image.memory(
//                           snapshot.data!,
//                           fit: BoxFit.cover,
//                         ),
//                       );
//                     }
//                     return Container(color: Colors.grey);
//                   },
//                 ),
//                 // Align(
//                 //   alignment: Alignment.topRight,
//                 //   child: Checkbox(
//                 //     value: _selectedImages.contains(asset),
//                 //     onChanged: (isSelected) {
//                 //       setState(() {
//                 //         if (isSelected == true) {
//                 //           _selectedImages.add(asset);
//                 //         } else {
//                 //           _selectedImages.remove(asset);
//                 //         }
//                 //       });
//                 //     },
//                 //     checkColor: Colors.white,
//                 //     activeColor: Colors.blue,
//                 //   ),
//                 // ),
//                 Align(
//                     alignment: Alignment.topRight,
//                   child: Container(
//                     margin:const EdgeInsets.only(top: 10,right: 10),
//                     height: 20,
//                     width: 20,
//                     decoration:BoxDecoration(
//                         shape: BoxShape.circle,
//                         color: Colors.white
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         }).toList();
//
//         setState(() {
//           _mediaList.addAll(temp);
//           currentPage++;
//         });
//       }
//     } else {
//       PhotoManager.openSetting();
//     }
//   }
//
//   // Confirm and display selected images on the main screen
//   void _confirmSelection() async {
//     List<Widget> selectedWidgets = _selectedImages.map((asset) {
//       return FutureBuilder<Uint8List?>(
//         future: asset.thumbnailDataWithSize(const ThumbnailSize(200, 200)),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.done && snapshot.data != null) {
//             return Image.memory(snapshot.data!, fit: BoxFit.cover);
//           }
//           return Container(color: Colors.grey);
//         },
//       );
//     }).toList();
//
//     setState(() {
//       _confirmedImages = selectedWidgets;
//       _selectedImages.clear(); // Clear selection after confirmation
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           // Display confirmed images at the top of the screen
//           if (_confirmedImages.isNotEmpty)
//             Expanded(
//               child: GridView.count(
//                 crossAxisCount: 3,
//                 children: _confirmedImages,
//               ),
//             ),
//           Expanded(
//             child: NotificationListener<ScrollNotification>(
//               onNotification: (ScrollNotification scroll) {
//                 _handleScrollEvent(scroll);
//                 return false;
//               },
//               child: GridView.builder(
//                 controller: widget.scrollCtr,
//                 itemCount: _mediaList.length,
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
//                 itemBuilder: (context, index) {
//                   return _mediaList[index];
//                 },
//               ),
//             ),
//           ),
//           ElevatedButton(
//             onPressed: _selectedImages.isNotEmpty ? _confirmSelection : null,
//             child: const Text('Confirm Selection'),
//           ),
//         ],
//       ),
//     );
//   }
// }

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
