import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../../../core/assets.dart';

class CustomNavBar extends StatefulWidget {
  const CustomNavBar({super.key});

  @override
  _CustomNavBarState createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text('Selected Index: $_selectedIndex'),
          ),
        ],
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
          tabBackgroundColor: Colors.blue.shade100.withOpacity(0.5),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
              leading: Container(
                height: 16,
                width: 16,
                margin: const EdgeInsets.symmetric(horizontal: 5),
                // decoration: const BoxDecoration(
                // image: DecorationImage(image: AssetImage(Asset.iconHome),fit: BoxFit.contain),
                // color: Colors.white
                // ),
                child: Image.asset(Asset.iconHome,color: _selectedIndex == 0? Colors.blue:Colors.grey[800],),
              ),
              text: 'Home',
              iconColor: Colors.transparent, // Làm icon trở nên vô hình
            ),
            GButton(
              // iconMarket
              icon: Icons.notifications_none,
              leading: Container(
                height: 16,
                width: 16,
                margin: const EdgeInsets.symmetric(horizontal: 5),
                child: Image.asset(Asset.iconMarket,color: _selectedIndex == 1? Colors.blue:Colors.grey[800],),
              ),
              text: 'Marketplace',
              iconColor: Colors.transparent, //
            ),
            GButton(
              // iconMarket
              icon: Icons.notifications_none,
              leading: Container(
                height: 16,
                width: 16,
                margin: const EdgeInsets.symmetric(horizontal: 5),
                child: Image.asset(Asset.iconMessage1,color: _selectedIndex == 2? Colors.blue:Colors.grey[800],),
              ),
              text: 'Message',
              iconColor: Colors.transparent, //
            ),
            const GButton(
              // iconMarket
              icon: Icons.notifications_none,
              leading: Padding(
                padding: EdgeInsets.symmetric(horizontal:5.0),
                child: CircleAvatar(
                  radius: 15,
                  backgroundImage:AssetImage(Asset.bgImageAvatar) ,
                ),
              ),
              // leading: Container(
              //   height: 16,
              //   width: 16,
              //   margin: const EdgeInsets.symmetric(horizontal: 5),
              //   child: Image.asset(Asset.bgImageAvatar,color: _selectedIndex == 3? Colors.blue:Colors.grey[800],),
              // ),
              text: 'User',
              iconColor: Colors.transparent, //
            ),
          ],
        ),
      ),
    );
  }
}