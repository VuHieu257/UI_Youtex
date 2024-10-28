import 'package:flutter/material.dart';

import '../../../../core/assets.dart';
import '../../../../core/colors/color.dart';

class SearchMessage1 extends StatefulWidget {
  const SearchMessage1({super.key});

  @override
  State<SearchMessage1> createState() => _SearchMessage1State();
}

class _SearchMessage1State extends State<SearchMessage1> {
  bool _showSearchResult = false
  ; // Trạng thái để điều khiển hiển thị "Kết quả thứ 10/18"

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 40,
        elevation: 0,
        backgroundColor: Styles.blue,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back_ios, color: Styles.light),
        ),
        title: SizedBox(
          height: 40,
          child: TextField(
            onChanged: (value) {
              setState(() {
                // Xử lý khi người dùng nhập vào ô tìm kiếm
                _showSearchResult = value.isNotEmpty;
              });
            },
            decoration: InputDecoration(
              hintText: "Tìm kiếm",
              prefixIcon: const Icon(Icons.search),
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(10),
              children: [
                // Tin nhắn của khách hàng
                _buildMessageBubble(
                  context,
                  alignment: Alignment.centerLeft,
                  text: "Chào anh/chị, tôi đang tìm mua vài loại vải \ncotton. Anh/chị có thể giới thiệu cho tôi \nkhông?",
                  isCustomer: true,
                ),
                // Tin nhắn phản hồi của cửa hàng
                _buildMessageBubble(
                  context,
                  alignment: Alignment.centerRight,
                  text: "Chào anh/chị, chúng tôi có nhiều loại vải \ncotton với chất lượng và giá cả khác nhau.",
                  isCustomer: false,
                ),
                _buildMessageBubble(
                  context,
                  alignment: Alignment.centerRight,
                  text: "Anh/chị đang cần loại vải có độ dày thế nào và dùng để may gì ạ?.",
                  isCustomer: false,
                ),
                _buildMessageBubble(
                  context,
                  alignment: Alignment.centerLeft,
                  text: "Tôi cần vải cotton mềm, thoáng khí để may áo sơ mi.",
                  isCustomer: true,
                ),
                _buildMessageBubble(
                  context,
                  alignment: Alignment.centerLeft,
                  text: "Anh/chị có loại nào phù hợp không?.",
                  isCustomer: true,
                ),
                _buildMessageBubble(
                  context,
                  alignment: Alignment.centerLeft,
                  text: "Chúng tôi có loại cotton 100%, mềm mịn và rất thoáng khí, giá 200,000 đồng/mét.",
                  isCustomer: false,
                ),
                _buildMessageBubble(
                  context,
                  alignment: Alignment.centerLeft,
                  text: "Nếu anh/chị mua số lượng lớn, chúng tôi sẽ giảm giá.",
                  isCustomer: false,
                ),
              ],
            ),
          ),
          // Ô nhập tin nhắn
          if (_showSearchResult)

            const Padding(
            padding: EdgeInsets.all(8.0),
             child:
             Text(
              "Kết quả thứ 10/18",
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
          ),
          // Ô nhập tin nhắn
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Nhập tin nhắn...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    // Xử lý gửi tin nhắn
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(BuildContext context, {required Alignment alignment, required String text, required bool isCustomer}) {
    return Align(
      alignment: alignment,
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: isCustomer ? Colors.white : Colors.blue[100],
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isCustomer)
              const CircleAvatar(
                backgroundImage: AssetImage(Asset.bgImageAvatar), // Thay thế bằng ảnh thực tế
              ),
            if (isCustomer) const SizedBox(width: 20),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(fontSize: 14),
              ),
            ),
            if (!isCustomer) const SizedBox(width: 10),
            if (!isCustomer)
              const CircleAvatar(
                backgroundImage: AssetImage(Asset.bgImageAvatar), // Thay thế bằng ảnh thực tế
              ),
          ],
        ),
      ),
    );
  }
}
