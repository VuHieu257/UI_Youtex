import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddRolePage extends StatefulWidget {
  @override
  _AddRolePageState createState() => _AddRolePageState();
}

class _AddRolePageState extends State<AddRolePage> {
  final List<Map<String, String>> users = [
    {'name': 'John Michael', 'image': 'assets/john_michael.jpg'},
    {'name': 'John David', 'image': 'assets/john_david.jpg'},
    {'name': 'John Paul', 'image': 'assets/john_paul.jpg'},
    {'name': 'John Robert', 'image': 'assets/john_robert.jpg'},
    {'name': 'John William', 'image': 'assets/john_william.jpg'},
    {'name': 'John Edward', 'image': 'assets/john_edward.jpg'},
    {'name': 'John Henry', 'image': 'assets/john_henry.jpg'},
    {'name': 'John James', 'image': 'assets/john_james.jpg'},
  ];

  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Action to go back
          },
        ),
        title: Text("Quyền truy cập trang"),
        backgroundColor: Colors.blue,
        actions: [
          TextButton(
            onPressed: () {
              // Cancel action
            },
            child: Text(
              "Hủy",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: "John",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                fillColor: Colors.grey[200],
                filled: true,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                String userName = users[index]['name']!;
                if (searchQuery.isEmpty || userName.toLowerCase().contains(searchQuery.toLowerCase())) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage(users[index]['image']!), // Profile image path
                    ),
                    title: Text(userName),
                    onTap: () {
                      // Action for selecting user
                      setState(() {
                        // Handle selection, if needed
                      });
                    },
                    selected: userName == "John Henry", // Example of selecting a user
                    selectedTileColor: Colors.blue[50],
                    trailing: userName == "John Henry"
                        ? Icon(Icons.check_box, color: Colors.blue)
                        : null,
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}