import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ui_youtex/core/assets.dart';
import 'package:ui_youtex/core/colors/color.dart';

class BioEditPage extends StatelessWidget {
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
         actions: [
          TextButton(
            onPressed: () {
              // Save action
            },
            child: Text(
              "Lưu",
              style: TextStyle(
                color: Styles.light,
                fontSize: 16,
              ),
            ),
          ),
        ],
        backgroundColor: Styles.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage(Asset.bg_ava_)// Add profile image asset here
                ),
                SizedBox(width: 10),
                Text(
                  "Youtextile",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 20),
            TextField(
              maxLength: 255,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: "Cung cấp đa dạng các loại vải trên thị trường.",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 5),
            Align(
              alignment: Alignment.bottomRight,

            ),
          ],
        ),
      ),
    );
  }
}