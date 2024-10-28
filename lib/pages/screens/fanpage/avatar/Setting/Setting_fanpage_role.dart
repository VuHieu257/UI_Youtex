import 'package:flutter/material.dart';

class AccessPage extends StatelessWidget {
  const AccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Action to go back
          },
        ),
        title: const Text("Quyền truy cập trang"),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              // Action for the more button
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Người có quyền truy cập vào Youtextile",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  onTap: () {
                    // Add new person action
                  },
                  child: const Text(
                    "Thêm mới",
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _buildUserItem(
                  "John Doe",
                  "Nội dung, Tin nhắn và cuộc gọi. Hoạt động trong cộng đồng, Quảng cáo, Thông tin chi tiết, Quyền, Xóa Trang",
                  'assets/john_doe.jpg', // Profile image path
                ),
                _buildUserItem(
                  "William Wean",
                  "Nội dung, Tin nhắn và cuộc gọi. Hoạt động trong cộng đồng, Quảng cáo, Thông tin chi tiết, Quyền, Xóa Trang",
                  'assets/william_wean.jpg', // Profile image path
                ),
              ],
            ),
          ),
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: const Row(
              children: [
                Icon(Icons.cancel, color: Colors.black),
                SizedBox(width: 10),
                Text(
                  "Gỡ khỏi trang",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserItem(String name, String roles, String profileImage) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: AssetImage(profileImage), // You can use NetworkImage for online images
      ),
      title: Text(name),
      subtitle: Text(roles),
      trailing: const Icon(Icons.more_vert),
      onTap: () {
        // Action for tapping the user
      },
    );
  }
}