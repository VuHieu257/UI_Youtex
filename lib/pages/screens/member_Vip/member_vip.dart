import 'package:flutter/material.dart';
import 'package:ui_youtex/pages/screens/member_Vip/cardInput_app.dart';
import 'package:ui_youtex/pages/screens/member_Vip/member_payment_vnpay.dart';

class PremiumUnlockScreen extends StatelessWidget {
  // Define custom colors
  final Color primaryBlue = Color(0xFF6DA7FF);
  final Color lightBlue = Color(0xFFDAF5FF);
  final Color backgroundBlue = Color(0xFFE2EEF3);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              lightBlue, // DAF5FF
              backgroundBlue, // E2EEF3
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildAppBar(context),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildHeader(),
                        SizedBox(height: 32),
                        _buildFeaturesList(),
                        SizedBox(height: 32),
                        _buildTrialSwitch(),
                        SizedBox(height: 24),
                        _buildSubscriptionOptions(),
                        SizedBox(height: 32),
                        _buildBottomSection(context),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.withOpacity(0.1),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black87),
            onPressed: () => Navigator.pop(context),
          ),
          SizedBox(width: 8),
          Text(
            'Gói thành viên Premium',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Mở khóa Premium',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Tận hưởng những lợi ích này khi bạn nâng cấp lên gói cao cấp',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildFeaturesList() {
    final features = [
      'Quản lý Mall riêng',
      'Hỗ trợ PR & Marketing',
      'Bảo hiểm đơn hàng - Buff Youtex',
      'Xây dựng uy tín doanh nghiệp - Dấu chân Youtex',
      'Quyền lợi ưu tiên trong sự kiện',
      'Tài khoản quản lý cho Mall',
    ];

    return Column(
      children: features.map((feature) => _buildFeatureItem(feature)).toList(),
    );
  }

  Widget _buildFeatureItem(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: lightBlue,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(
              Icons.check_circle,
              color: primaryBlue,
              size: 22,
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrialSwitch() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.7),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Bắt đầu dùng thử miễn phí 7 ngày',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          Switch(
            value: true,
            onChanged: (value) {},
            activeColor: primaryBlue,
          ),
        ],
      ),
    );
  }

  Widget _buildSubscriptionOptions() {
    return Column(
      children: [
        _buildSubscriptionOption(
          'Tháng',
          '1.990.000đ/tháng',
          isSelected: true,
        ),
        _buildSubscriptionOption(
          '3 tháng',
          '1.990.000đ/3 tháng',
          discountTag: 'Save 17%',
        ),
        _buildSubscriptionOption(
          'Year',
          '10.990.000đ/năm',
          discountTag: 'Best choice/Save 54%',
          isPopular: true,
        ),
      ],
    );
  }

  Widget _buildSubscriptionOption(
    String title,
    String price, {
    bool isSelected = false,
    String? discountTag,
    bool isPopular = false,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: isSelected
            ? lightBlue.withOpacity(0.7)
            : Colors.white.withOpacity(0.7),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isSelected ? primaryBlue : Colors.grey.withOpacity(0.2),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            Radio(
              value: true,
              groupValue: isSelected,
              onChanged: (value) {},
              activeColor: primaryBlue,
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (discountTag != null) ...[
                        SizedBox(width: 8),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: primaryBlue,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            discountTag,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  SizedBox(height: 4),
                  Text(
                    price,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomSection(BuildContext context) {
    return Column(
      children: [
        Text(
          'Chưa mất phí. Có thể hủy bất cứ lúc nào.',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 14,
          ),
        ),
        SizedBox(height: 24),
        Container(
          width: double.infinity,
          height: MediaQuery.sizeOf(context).height / 14,
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
              showPaymentMethodSheet(context);
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
              'Tiếp Tục',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// Payment Method Model
class PaymentMethod {
  final String name;
  final String logo;
  final bool isSelected;

  PaymentMethod({
    required this.name,
    required this.logo,
    this.isSelected = false,
  });
}

// Bottom Sheet Widget
void showPaymentMethodSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (context) => PaymentMethodBottomSheet(),
  );
}

class PaymentMethodBottomSheet extends StatefulWidget {
  @override
  _PaymentMethodBottomSheetState createState() =>
      _PaymentMethodBottomSheetState();
}

class _PaymentMethodBottomSheetState extends State<PaymentMethodBottomSheet> {
  int selectedMethodIndex = 0;

  final List<PaymentMethod> paymentMethods = [
    PaymentMethod(
      name: 'Thẻ',
      logo: 'assets/images/thẻ.png',
      isSelected: true,
    ),
    PaymentMethod(
      name: 'VnPay',
      logo: 'assets/images/VnPay.png',
    ),
    // Add more payment methods as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHeader(),
          _buildPaymentMethods(),
          // _buildConfirmButton(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.withOpacity(0.2),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          Text(
            'Chọn phương thức thanh toán',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          Spacer(),
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethods() {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: paymentMethods.length,
      itemBuilder: (context, index) {
        return _buildPaymentMethodItem(index);
      },
    );
  }

  Widget _buildPaymentMethodItem(int index) {
    final method = paymentMethods[index];
    final isSelected = selectedMethodIndex == index;

    return InkWell(
      onTap: () {
        // Điều hướng đến các trang khác nhau dựa trên tên của phương thức thanh toán
        if (method.name == 'Thẻ') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CardInputApppayPayment()),
          );
        } else if (method.name == 'VnPay') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PaymenVNPaytScreen()),
          );
        }
        // Bạn có thể thêm điều kiện cho các phương thức thanh toán khác ở đây

        setState(() {
          selectedMethodIndex = index;
        });
      },
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xFFDAF5FF) : Colors.white,
          border: Border(
            bottom: BorderSide(
              color: Colors.grey.withOpacity(0.2),
              width: 1,
            ),
          ),
        ),
        child: Row(
          children: [
            Radio(
              value: index,
              groupValue: selectedMethodIndex,
              onChanged: (value) {
                setState(() {
                  selectedMethodIndex = value as int;
                });
              },
              activeColor: Color(0xFF6DA7FF),
            ),
            Text(
              method.name,
              style: TextStyle(
                fontSize: 16,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
            SizedBox(width: 12),
            Container(
              child: Image.asset(
                method.logo,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 12),
            if (method.name == 'Thẻ') ...[
              Spacer(),
              Row(
                children: [
                  _buildCardIcon(),
                  SizedBox(width: 10),
                  _buildCardIcon(),
                  SizedBox(width: 8),
                  _buildCardIcon(),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildCardIcon() {
    return Container(
      width: 32,
      height: 20,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }

  Widget _buildConfirmButton() {
    return Container(
      width: double.infinity,
      height: MediaQuery.sizeOf(context).height / 14,
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
          final selectedPaymentMethod = paymentMethods[selectedMethodIndex];
          print('Selected Payment Method: ${selectedPaymentMethod.name}');
          Navigator.pop(context);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          elevation: 0,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Text(
          'Xác nhận',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

// Usage Example:
class PaymentButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => showPaymentMethodSheet(context),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(Icons.payment, color: Color(0xFF6DA7FF)),
            SizedBox(width: 12),
            Text(
              'Chọn phương thức thanh toán',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 16,
              ),
            ),
            Spacer(),
            Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
