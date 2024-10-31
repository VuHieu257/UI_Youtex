import 'package:flutter/material.dart';
import 'package:ui_youtex/core/colors/color.dart';

class MallInfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('Thông tin Mall', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        decoration: _buildGradientBackground(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(height: 100),
              MallInfoButton(
                  title: 'Thông tin doanh nghiệp',
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BusinessInfoScreen()));
                  }),
              SizedBox(height: 16),
              MallInfoButton(
                  title: 'Giấy tờ',
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DocumentInfoScreen()));
                  }),
              SizedBox(height: 16),
              MallInfoButton(
                  title: 'Ngân hàng',
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BankInfoScreen()));
                  }),
              SizedBox(height: 16),
              MallInfoButton(
                  title: 'Mô tả shop',
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ShopDescriptionScreen()));
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

BoxDecoration _buildGradientBackground() {
  return BoxDecoration(
    gradient: LinearGradient(
      colors: [Color(0xFF13538C), Color(0xFF218FF2)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  );
}

class MallInfoButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  MallInfoButton({required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 18, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[800]),
            ),
            Icon(Icons.arrow_forward_ios, color: Colors.grey[800], size: 18),
          ],
        ),
      ),
    );
  }
}

class BusinessInfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _buildTransparentAppBar(context, 'Thông tin doanh nghiệp'),
      body: Container(
        decoration: _buildGradientBackground(),
        child: _buildFormContent(
          context, // Truyền context vào đây
          [
            CustomTextField(label: 'Mã số thuế doanh nghiệp'),
            CustomTextField(label: 'Địa chỉ đăng ký kinh doanh'),
            CustomTextField(label: 'Số giấy phép kinh doanh'),
          ],
        ),
      ),
    );
  }
}

class DocumentInfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _buildTransparentAppBar(context, 'Giấy tờ'),
      body: Container(
        decoration: _buildGradientBackground(),
        child: _buildFormContent(
            context, // Truyền context vào đây
            [
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Loại giấy tờ (CCCD/CMND/Hộ Chiếu)',
                  labelStyle: TextStyle(
                    color: Colors.white, // Đổi thành màu bạn muốn
                  ),
                ),
                items: ['CCCD', 'CMND', 'Hộ Chiếu'].map((String value) {
                  return DropdownMenuItem<String>(
                      value: value, child: Text(value));
                }).toList(),
                onChanged: (newValue) {},
              ),
              CustomTextField(label: 'Số giấy tờ'),
              CustomTextField(label: 'Ảnh giấy tờ (mặt trước)'),
              CustomTextField(label: 'Ảnh giấy tờ (mặt sau)'),
            ]),
      ),
    );
  }
}

class BankInfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _buildTransparentAppBar(context, 'Ngân hàng'),
      body: Container(
        decoration: _buildGradientBackground(),
        child: _buildFormContent(
            context, // Truyền context vào đây
            [
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                    labelText: 'Tên ngân hàng',
                    labelStyle: TextStyle(color: Colors.white)),
                items: ['Vietcombank', 'ACB', 'TPBank'].map((String value) {
                  return DropdownMenuItem<String>(
                      value: value, child: Text(value));
                }).toList(),
                onChanged: (value) {},
              ),
              CustomTextField(label: 'Số tài khoản ngân hàng'),
              CustomTextField(label: 'Thẻ tín dụng hoặc thẻ ghi nợ (nếu có)'),
            ]),
      ),
    );
  }
}

class ShopDescriptionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _buildTransparentAppBar(context, 'Mô tả shop'),
      body: Container(
        decoration: _buildGradientBackground(),
        child: _buildFormContent(
            context, // Truyền context vào đây
            [
              CustomTextField(label: 'Mô tả shop', maxLines: 4),
            ]),
      ),
    );
  }
}

PreferredSizeWidget _buildTransparentAppBar(
    BuildContext context, String title) {
  return AppBar(
    title: Text(title, style: TextStyle(color: Colors.white)),
    backgroundColor: Colors.transparent,
    elevation: 0,
    leading: IconButton(
      icon: Icon(Icons.arrow_back, color: Colors.white),
      onPressed: () => Navigator.pop(context),
    ),
  );
}

Widget _buildFormContent(BuildContext context, List<Widget> fields) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      children: [
        SizedBox(height: 100),
        Expanded(
          child: Column(
            children: [
              ...fields,
              Spacer(),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color(0xFF218FF2), // Light blue
                Color(0xFF13538C), // Dark blue
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(30),
          ),
          child: ElevatedButton(
            onPressed: () {
              showSuccessPopup(context); // Gọi showSuccessPopup với context
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              elevation: 0,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: const Text(
              'Lưu Thay Đổi',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

class CustomTextField extends StatelessWidget {
  final String label;
  final int maxLines;

  CustomTextField({required this.label, this.maxLines = 1});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextField(
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Styles.dark, fontSize: 16),
          filled: true,
          fillColor: Colors.grey[100],
          contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey[300]!),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Color(0xFF1565C0), width: 1.5),
          ),
        ),
        style: TextStyle(fontSize: 16, color: Colors.grey[800]),
      ),
    );
  }
}

void showSuccessPopup(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        contentPadding: EdgeInsets.all(20),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 50,
            ),
            SizedBox(height: 16),
            Text(
              'Thành công!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Thay đổi của bạn đang được duyệt. Vui lòng đợi!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF218FF2), // Màu nền của nút
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'Cảm ơn',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ),
      );
    },
  );
}
