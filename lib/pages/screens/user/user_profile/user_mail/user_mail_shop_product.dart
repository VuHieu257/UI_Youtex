import 'package:flutter/material.dart';

class ProductManagementScreen extends StatelessWidget {
  const ProductManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quản lý sản phẩm'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
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
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Product List
            Expanded(
              child: ListView.builder(
                itemCount: 2, // Replace with actual product count
                itemBuilder: (context, index) {
                  return const ProductCard();
                },
              ),
            ),

            // Add Product Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.add),
                label: const Text('Thêm sản phẩm'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AddProductScreen()),
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
  const ProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
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
            const SizedBox(height: 8),
            const Text(
              'Tên sản phẩm: Vải 100% Cotton',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            const Text('Số lượng: 200'),
            const Text('Loại sản phẩm: Vải Cotton'),
            const Text('Lượt bán: 500'),
            const Row(
              children: [
                Text('Đánh giá: ', style: TextStyle(fontSize: 14)),
                Icon(Icons.star, color: Colors.amber, size: 16),
                Icon(Icons.star, color: Colors.amber, size: 16),
                Icon(Icons.star, color: Colors.amber, size: 16),
                Icon(Icons.star, color: Colors.amber, size: 16),
                Icon(Icons.star_border, color: Colors.amber, size: 16),
              ],
            ),
            const SizedBox(height: 4),
            const Text('Giá: 150.000đ', style: TextStyle(color: Colors.red)),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(onPressed: () {}, child: const Text('Chỉnh sửa')),
                TextButton(
                  onPressed: () {},
                  child: const Text('Xóa', style: TextStyle(color: Colors.red)),
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
  const AddProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thêm sản phẩm'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
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
            const TextField(
              decoration: InputDecoration(
                labelText: 'Tên sản phẩm',
                hintText: 'Điền thông tin tại đây',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // Cover Image Section
            const Text('Hình ảnh bìa',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Container(
              height: 150,
              color: Colors.grey[200],
              child: IconButton(
                icon: const Icon(Icons.add_a_photo),
                onPressed: () {
                  // Open image picker for cover photo
                },
              ),
            ),
            const SizedBox(height: 16),

            // Additional Images/Video Section
            const Text('Hình ảnh / video sản phẩm 0/6',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                6,
                (index) => Container(
                  height: 80,
                  width: 80,
                  color: Colors.grey[200],
                  child: IconButton(
                    icon: const Icon(Icons.add_a_photo),
                    onPressed: () {
                      // Open image picker for additional photos/videos
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Action Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Quay lại'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Submit product info
                  },
                  child: const Text('Tiếp tục'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
