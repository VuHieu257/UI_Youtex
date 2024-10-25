import 'package:flutter/material.dart';

class VoucherScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Mã giảm giá',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Column(
        children: [
          // Thanh chức năng với 2 nút
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Nút "Nhập mã voucher"
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.analytics_rounded, color: Colors.blue),
                  label: Text('Nhập Mã Voucher',
                      style: TextStyle(color: Colors.black)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(color: Colors.grey),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    shadowColor: Colors.grey.withOpacity(0.5),
                    elevation: 4, // Đổ bóng nhẹ
                  ),
                ),
                // Nút "Tìm thêm voucher"
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.airplane_ticket, color: Colors.blue),
                  label: Text('Tìm thêm voucher',
                      style: TextStyle(color: Colors.black)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(color: Colors.grey),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    shadowColor: Colors.grey.withOpacity(0.5),
                    elevation: 4, // Đổ bóng nhẹ
                  ),
                ),
              ],
            ),
          ),

          // Danh sách voucher
          Expanded(
            child: ListView.builder(
              itemCount: 4, // Số lượng voucher
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: Card(
                    color: Colors.blue[50], // Màu nền xanh nhạt
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 6, // Đổ bóng đậm hơn
                    shadowColor: Colors.grey.withOpacity(0.3),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          // Icon mã giảm giá
                          Container(
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  spreadRadius: 2,
                                  blurRadius: 6,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Icon(Icons.local_offer,
                                size: 40, color: Colors.blue),
                          ),
                          SizedBox(width: 12),
                          // Nội dung voucher
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Giảm 20% cho tất cả các mặt hàng',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.black87,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text('Đơn tối thiểu 100k',
                                    style: TextStyle(color: Colors.black54)),
                                SizedBox(height: 4),
                                Text('Có hiệu lực đến ngày 1/12/2024',
                                    style: TextStyle(color: Colors.black54)),
                              ],
                            ),
                          ),
                          // Nút "Dùng sau"
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              backgroundColor:
                                  Colors.blue, // Nền gradient cho nút
                              elevation: 3,
                              shadowColor: Colors.blue.withOpacity(0.3),
                            ),
                            child: Text(
                              'Dùng sau',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
