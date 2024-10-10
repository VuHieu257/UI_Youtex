import 'package:flutter/material.dart';

import '../../../../core/assets.dart';
import '../../home/product/adress/adress_add_screen.dart';
import '../../home/product/adress/adress_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Avatar, name, and username
            Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage(Asset.bgImageAvatar), // Avatar image
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Rosalind Quinn',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        const Text('@rosalind'),
                        const SizedBox(width: 5),

                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        'Premium',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Personal Information Section
            const Text(
              'Personal information',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ListTile(
              title: const Text('Email address'),
              trailing: const Text('userdesign@gmail.com'),
            ),
            ListTile(
              title: const Text('Phone number'),
              trailing: const Text('+84 (234) 567-8901'),
            ),
            const SizedBox(height: 24),

            // Password & Security Section
            const Text(
              'Password & security',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ListTile(
              title: const Text('Change password'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Navigate to Change Password screen
              },
            ),
            const Divider(),

            // Account Settings Section
            const Text(
              'Account settings',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ListTile(
              title: const Text('Notifications'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Navigate to Notifications settings
              },
            ),
            const Divider(),
            ListTile(
              title: const Text('Payment methods'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Navigate to Payment Methods screen
              },
            ),
            const Divider(),
            ListTile(
              title: const Text('Shipping addresses'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () { Navigator.push(context, MaterialPageRoute(builder: (context) =>   AddressScreen(),));
                // Navigate to Shipping Addresses screen
              },
            ),
          ],
        ),
      ),
    );
  }
}
