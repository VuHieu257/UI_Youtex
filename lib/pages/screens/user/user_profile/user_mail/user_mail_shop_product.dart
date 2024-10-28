import 'package:flutter/material.dart';

class ProductManagementScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quản lý sản phẩm'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              // Show filter options
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search Bar
            TextField(
              decoration: InputDecoration(
                hintText: 'Tìm sản phẩm',
                prefixIcon: Icon(Icons.search),
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 16),

            // Product List
            Expanded(
              child: ListView.builder(
                itemCount: 2, // Replace with actual product count
                itemBuilder: (context, index) {
                  return ProductCard();
                },
              ),
            ),

            // Add Product Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: Icon(Icons.add),
                label: Text('Thêm sản phẩm'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddProductScreen()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                'assets/images/5432689438a0de5026c27269c380ba9e.jpg',
                fit: BoxFit.cover,
                height: 150,
                width: double.infinity,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Tên sản phẩm: Vải 100% Cotton',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text('Số lượng: 200'),
            Text('Loại sản phẩm: Vải Cotton'),
            Text('Lượt bán: 500'),
            Row(
              children: [
                Text('Đánh giá: ', style: TextStyle(fontSize: 14)),
                Icon(Icons.star, color: Colors.amber, size: 16),
                Icon(Icons.star, color: Colors.amber, size: 16),
                Icon(Icons.star, color: Colors.amber, size: 16),
                Icon(Icons.star, color: Colors.amber, size: 16),
                Icon(Icons.star_border, color: Colors.amber, size: 16),
              ],
            ),
            SizedBox(height: 4),
            Text('Giá: 150.000đ', style: TextStyle(color: Colors.red)),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(onPressed: () {}, child: Text('Chỉnh sửa')),
                TextButton(
                  onPressed: () {},
                  child: Text('Xóa', style: TextStyle(color: Colors.red)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Add Product Screen
class AddProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thêm sản phẩm'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Name Field
            TextField(
              decoration: InputDecoration(
                labelText: 'Tên sản phẩm',
                hintText: 'Điền thông tin tại đây',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),

            // Cover Image Section
            Text('Hình ảnh bìa',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Container(
              height: 150,
              color: Colors.grey[200],
              child: IconButton(
                icon: Icon(Icons.add_a_photo),
                onPressed: () {
                  // Open image picker for cover photo
                },
              ),
            ),
            SizedBox(height: 16),

            // Additional Images/Video Section
            Text('Hình ảnh / video sản phẩm 0/6',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                6,
                (index) => Container(
                  height: 80,
                  width: 80,
                  color: Colors.grey[200],
                  child: IconButton(
                    icon: Icon(Icons.add_a_photo),
                    onPressed: () {
                      // Open image picker for additional photos/videos
                    },
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),

            // Action Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Quay lại'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Submit product info
                  },
                  child: Text('Tiếp tục'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
