import 'package:flutter/material.dart';
import 'package:ui_youtex/core/assets.dart';
import 'package:ui_youtex/core/colors/color.dart';

class HomeMain extends StatelessWidget {
  const HomeMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Image.asset(Asset.bgLogo, height: 40), // Adjust logo size
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () {},
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Banner Section
            Image.asset(
              Asset.bgCustomer5,
              width: double.infinity,
              height: 180, // Adjust height to match the design
              fit: BoxFit.cover,
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Featured Companies Section
                  Text(
                    'Doanh nghiệp nổi bật',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FeaturedCompanyCard(
                        imageUrl: Asset.bgCustomer1,
                        title: 'Vinatex',
                      ),
                      FeaturedCompanyCard(
                        imageUrl: Asset.bgCustomer2,
                        title: 'Vingroup',
                      ),
                      FeaturedCompanyCard(
                        imageUrl: Asset.bgCustomer3,
                        title: 'Viet Tien',
                      ),
                      FeaturedCompanyCard(
                        imageUrl: Asset.bgCustomer3,
                        title: 'Yame',
                      ),
                    ],
                  ),
                  SizedBox(height: 24),

                  // News Card
                  NewsCard(
                    imageUrl: Asset.bgCustomer1,
                    title: 'THƯƠNG HIỆU DỆT MAY VIỆT 2024',
                    description: '...',
                  ),
                  SizedBox(height: 16),

                  // Promotion Card
                  PromotionCard(),
                  SizedBox(height: 16),

                  // News Card
                  NewsCard(
                    imageUrl: Asset.bgCustomer2,
                    title: 'KHAI TRƯƠNG CHI NHÁNH THỨ 10',
                    description: '...',
                  ),
                  SizedBox(height: 24),

                  // Highlighted Posts Section
                  Text(
                    'Bài đăng nổi bật',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  HighlightedPostCard(
                    imageUrl: Asset.bgCustomer4,
                    title: 'KỶ NIỆM 10 NĂM THÀNH LẬP HẢI ANH',
                    description: 'Kỷ niệm 10 năm của công ty...',
                    rating: 5,
                    actions: ['Xem thêm', 'Nhận quà'],
                  ),
                  SizedBox(height: 16),
                  HighlightedPostCard(
                    imageUrl: Asset.bgCustomer4,
                    title: 'CHUNG TAY CÙNG VINID XÂY TRƯỜNG MỚI',
                    description:
                        'Cùng chung tay với VinID để xây trường mới...',
                    rating: 4,
                    actions: ['Xem thêm', 'Tham gia'],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Featured Company Card
class FeaturedCompanyCard extends StatelessWidget {
  final String imageUrl;
  final String title;

  const FeaturedCompanyCard({
    super.key,
    required this.imageUrl,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 28,
          backgroundColor: Colors.grey[100],
          child: Image.asset(imageUrl, height: 50),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}

// News Card
class NewsCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;

  const NewsCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Styles.light,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
            child: Image.asset(
              imageUrl,
              width: double.infinity,
              height: 150,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(description, style: const TextStyle(fontSize: 14)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Promotion Card
class PromotionCard extends StatelessWidget {
  const PromotionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      color: Colors.blue[700],
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Giảm đến 20%',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Ưu đãi đặc biệt',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ],
              ),
            ),
            Image.asset(
              Asset.bgCustomer5,
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}

// Highlighted Post Section (Bài đăng nổi bật)
class HighlightedPostCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;
  final int rating; // Đánh giá
  final List<String> actions; // Các nút hành động

  const HighlightedPostCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.rating,
    required this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3, // Độ nổi của card
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // Bo góc cho card
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Phần ảnh của bài đăng
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
            child: Image.asset(
              imageUrl,
              width: double.infinity,
              height: 160, // Chiều cao ảnh
              fit: BoxFit.cover, // Chế độ hiển thị ảnh
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0), // Khoảng cách nội dung
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Tiêu đề bài đăng
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8), // Khoảng cách giữa tiêu đề và mô tả
                // Mô tả bài đăng
                Text(
                  description,
                  style: const TextStyle(fontSize: 14, color: Colors.black54),
                ),
                const SizedBox(height: 12),
                // Phần đánh giá sao
                Row(
                  children: [
                    for (int i = 0; i < 5; i++)
                      Icon(
                        i < rating ? Icons.star : Icons.star_border,
                        color: Colors.amber,
                        size: 18,
                      ),
                    const SizedBox(width: 8),
                    Text(
                      '$rating.0', // Hiển thị điểm đánh giá
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Nút hành động
                Row(
                  children: [
                    for (final action in actions)
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue[700], // Màu nền nút
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(20), // Bo góc nút
                            ),
                          ),
                          child: Text(action), // Tên nút
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
