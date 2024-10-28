import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../../../core/assets.dart';
import '../../screens/home/home.dart';
import '../../screens/home/home_mall.dart';
import '../../screens/live/live.dart';
import '../../screens/message/message.dart';
import '../../screens/shopping_cart_page/shopping_cart_page.dart';
import '../../screens/user/user_profile/user_profile.dart';
import '../../screens/user/user_selection_screen/user_selection_screen.dart';

class CustomNavBar extends StatefulWidget {
  const CustomNavBar({super.key});

  @override
  State<CustomNavBar> createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {

  int _selectedIndex = 0;
  final List<Widget> _screens = [
    const HomePage(),
    HomeMall(),
    const LiveScreen(),
    const MessagesScreen(),
    const ProfileScreen(),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar:
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 15),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(40),
            boxShadow: const [
              BoxShadow(
                  offset: Offset(4, 4),
                  blurRadius: 10,
                  color: Colors.black54
              )
            ]
        ),
        child: GNav(
          color: Colors.grey[800],
          activeColor: Colors.blue,
          hoverColor: Colors.blue.shade100,
          tabBackgroundColor: Colors.blue.shade100.withOpacity(0.5),
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          duration: const Duration(milliseconds: 800),
          selectedIndex: _selectedIndex,
          onTabChange: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          tabs: [
            GButton(
              icon:  Icons.home_outlined,
              leading: Image.asset(Asset.iconHome,color: _selectedIndex == 0? Colors.blue:Colors.grey[800],fit: BoxFit.fitHeight,height: 20,width: 20,),
              text: 'Trang chủ',
              iconColor: Colors.transparent, // Làm icon trở nên vô hình
            ),
            GButton(
              // iconMarket
              icon: Icons.notifications_none,
              leading: Container(
                height: 16,
                width: 16,
                margin: const EdgeInsets.symmetric(horizontal: 5),
                child: Image.asset(Asset.iconMarket,color: _selectedIndex == 1? Colors.blue:Colors.grey[800],fit: BoxFit.fitHeight,height: 20,width: 20,),
              ),
              text: 'Mall',
              iconColor: Colors.transparent, //
            ),
            GButton(
              icon: Icons.notifications_none,
              backgroundColor: Colors.red.shade200.withOpacity(0.3),
              leading: Container(
                height: 16,
                width: 16,
                margin: const EdgeInsets.symmetric(horizontal: 5),
                child: Image.asset(Asset.iconLive,color: _selectedIndex == 1? Colors.red:Colors.red,fit: BoxFit.fitHeight,height: 20,width: 20,),
              ),
              iconColor: Colors.transparent, //
            ),
            GButton(
              // iconMarket
              icon: Icons.notifications_none,
              leading: Container(
                height: 16,
                width: 16,
                margin: const EdgeInsets.symmetric(horizontal: 5),
                child: Image.asset(Asset.iconMessage1,color: _selectedIndex == 2? Colors.blue:Colors.grey[800],fit: BoxFit.fitHeight,height: 20,width: 20,),
              ),
              text: 'Tin Nhắn',
              iconColor: Colors.transparent, //
            ),
            const GButton(
              // iconMarket
              icon: Icons.notifications_none,
              leading: CircleAvatar(
                radius: 15,
                backgroundImage:AssetImage(Asset.bgImageAvatar) ,
              ),
              iconColor: Colors.transparent, //
            ),
          ],
          // tabs: const [
          //   GButton(
          //     icon:  Icons.home_outlined,
          //     text: 'Trang chủ',
          //   ),
          //   GButton(
          //     icon:  Icons.home_outlined,
          //     text: 'Trang chủ',
          //   ),
          //   GButton(
          //     // iconMarket
          //     icon: Icons.notifications_none,
          //     text: 'Mall',
          //   ),
          //   GButton(
          //     // iconMarket
          //     icon: Icons.notifications_none,
          //     text: 'Tin Nhắn',
          //   ),
          //   // GButton(
          //   //   // iconMarket
          //   //   icon: Icons.notifications_none,
          //   //   text: 'Tin Nhắn',
          //   // ),
          //   GButton(
          //     // iconMarket
          //     icon: Icons.notifications_none,
          //     leading: CircleAvatar(
          //       radius: 15,
          //       backgroundImage:AssetImage(Asset.bgImageAvatar) ,
          //     ),
          //     iconColor: Colors.transparent, //
          //   ),
          // ],
        ),
      ),
    );
  }
}