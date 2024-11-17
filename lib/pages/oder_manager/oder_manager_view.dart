import 'package:flutter/material.dart';
import '../screens/shopping_cart_page/information_order/information_oder.dart';

class OrderManagementScreen extends StatelessWidget {
  final List<Map<String, dynamic>> orders = [
    {
      "name": "Vải Cotton May Áo Phông",
      "image": "assets/images/home_product.png",
      "status": "Chờ xác nhận",
      "price": "1.987.000đ",
      "store": "Đồng phục Hải Anh",
      "quantity": "x5",
      "rating": "4.8",
      "color": "C410, Màu hồng",
      "unitPrice": "570.000đ"
    },
  ];

  OrderManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Quản lý đơn hàng',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          backgroundColor: Colors.blue,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          bottom: TabBar(
            isScrollable: true,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white.withOpacity(0.7),
            indicatorColor: Colors.white,
            tabs: const [
              Tab(text: 'Chờ xác nhận'),
              Tab(text: 'Chờ giao hàng'),
              Tab(text: 'Đã giao'),
              Tab(text: 'Đã hủy'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildOrderList("Chờ xác nhận"),
            _buildOrderList("Chờ giao hàng"),
            _buildOrderList("Đã giao"),
            _buildOrderList("Đã hủy"),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderList(String status) {
    return ListView.builder(
      itemCount: orders.length,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      itemBuilder: (context, index) {
        final order = orders[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        order["image"],
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            order["store"],
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF007BFF),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            order["name"],
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            order["color"],
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Text(
                                order["rating"],
                                style: const TextStyle(
                                  color: Colors.orange,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Icon(
                                Icons.star,
                                color: Colors.orange,
                                size: 16,
                              ),
                              const Spacer(),
                              Text(
                                order["unitPrice"],
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                order["quantity"],
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.local_shipping,
                              color: Color(0xFF007BFF),
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Đơn hàng đang chờ xác nhận',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'Thành tiền:',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              order["price"],
                              style: const TextStyle(
                                color: Color(0xFFD0006F),
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HistoryOrder(),
                            ),
                          );
                        },
                        child: const Text(
                          'Xem tình trạng đơn hàng',
                          style: TextStyle(
                            color: Color(0xFF007BFF),
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
