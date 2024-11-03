import 'package:flutter/material.dart';
import 'package:ui_youtex/core/size/size.dart';
import 'package:ui_youtex/pages/screens/member_Vip/cardInput_app.dart';
import 'package:ui_youtex/pages/screens/member_Vip/member_payment_vnpay.dart';

import '../../../core/assets.dart';

class PremiumUnlockScreen extends StatefulWidget {

  const PremiumUnlockScreen({super.key});

  @override
  State<PremiumUnlockScreen> createState() => _PremiumUnlockScreenState();
}

class _PremiumUnlockScreenState extends State<PremiumUnlockScreen> {
  // Define custom colors
  final Color primaryBlue = const Color(0xFF6DA7FF);

  final Color lightBlue = const Color(0xFFDAF5FF);

  final Color backgroundBlue = const Color(0xFFE2EEF3);

  bool switchValue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF6DA7FF),
              Color(0xFFDAF5FF),
              Color(0xFFDAF5FF),
            ],
            begin: Alignment.topRight,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  _buildAppBar(context),
                  _buildHeader(),
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(onPressed: () {
                      _showPremiumBenefitsDialog(context);
                    }, icon: const Icon(Icons.info_outline)),
                  ),
                  _buildFeaturesList(),
                  const SizedBox(height: 32),
                  _buildTrialSwitch(),
                  const SizedBox(height: 24),
                  _buildSubscriptionOptions(),
                  const SizedBox(height: 32),
                  _buildBottomSection(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
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
            icon: const Icon(Icons.arrow_back, color: Colors.black87),
            onPressed: () => Navigator.pop(context),
          ),
          const SizedBox(width: 8),
          const Text(
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
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
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
        SizedBox(
          width: 300,
          child: Text(
            'Tận hưởng những lợi ích này khi bạn nâng cấp lên gói cao cấp',
            style: TextStyle(
              fontSize: 16,
              color: Color(0xff626262),
              height: 1.5,
            ),
            textAlign: TextAlign.center,
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
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: features.map((feature) => _buildFeatureItem(feature)).toList(),
    );
  }

  Widget _buildFeatureItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 20,bottom: 10,top: 10),
      child: Row(
        children: [
          const Icon(
            Icons.check_circle_outline,
            color: Color(0xff5F6368),
            size: 22,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Bắt đầu dùng thử miễn phí 7 ngày',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        // Switch(
        //   value: switchValue,
        //   activeColor: Colors.white,
        //   activeTrackColor:Colors.blue,
        //   inactiveTrackColor: Colors.white,
        //   inactiveThumbColor: Colors.blue,
        //   onChanged: (bool newValue) {
        //     setState(() {
        //       switchValue = newValue;
        //     });
        //   },
        // ),
      ],
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
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color:Colors.white.withOpacity(0.7),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isSelected ? primaryBlue : Colors.grey.withOpacity(0.2),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Radio(
              value: true,
              groupValue: isSelected,
              onChanged: (value) {},
              activeColor: primaryBlue,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (discountTag != null) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: primaryBlue,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            discountTag,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 4),
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
        const SizedBox(height: 24),
        Container(
          width: double.infinity,
          height: MediaQuery.sizeOf(context).height / 14,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color(0xFF218FF2), // Light blue
                Color(0xFF13538C), // Dark blue
              ],
              begin: Alignment.centerRight,
              end: Alignment.centerLeft,
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
        const SizedBox(height: 24),
        Text(
          'Khôi phục mua hàng\tChính sách bảo mật\tĐiều khoản sử dụng',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 24),
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
    builder: (context) => const PaymentMethodBottomSheet(),
  );
}

class PaymentMethodBottomSheet extends StatefulWidget {
  const PaymentMethodBottomSheet({super.key});

  @override
  _PaymentMethodBottomSheetState createState() =>
      _PaymentMethodBottomSheetState();
}

class _PaymentMethodBottomSheetState extends State<PaymentMethodBottomSheet> {
  int selectedMethodIndex = 0;

  final List<PaymentMethod> paymentMethods = [
    PaymentMethod(
      name: 'Thẻ',
      logo: Asset.iconVisa,
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
      decoration: const BoxDecoration(
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
      padding: const EdgeInsets.all(16),
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
          const Text(
            'Chọn phương thức thanh toán',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethods() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
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
            MaterialPageRoute(builder: (context) => const CardInputApppayPayment()),
          );
        } else if (method.name == 'VnPay') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const PaymenVNPaytScreen()),
          );
        }
        // Bạn có thể thêm điều kiện cho các phương thức thanh toán khác ở đây

        setState(() {
          selectedMethodIndex = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFDAF5FF) : Colors.white,
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
              activeColor: const Color(0xFF6DA7FF),
            ),
            Text(
              method.name,
              style: TextStyle(
                fontSize: 16,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
            const SizedBox(width: 12),
            Image.asset(
              method.logo,
              fit: BoxFit.cover,
              height: 30,
            ),
            const SizedBox(width: 12),
            if (method.name == 'Thẻ') ...[
              Row(
                children: [
                  _buildCardIcon(Asset.iconVisa),
                  const SizedBox(width: 10),
                  _buildCardIcon(Asset.iconMastercard),
                  const SizedBox(width: 8),
                  _buildCardIcon(Asset.iconJCB),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildCardIcon(String assetName) {
    return Container(
      width: 32,
      height: 30,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        image:DecorationImage(image: AssetImage(assetName))
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
        child: const Text(
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
  const PaymentButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => showPaymentMethodSheet(context),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Row(
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


void _showPremiumBenefitsDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Container(
          height: context.height*0.9,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10))
          ),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Quyền lợi Premium',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildBenefitItem(
                        'Quản lý Mall riêng:',
                        [
                          'Tạo và vận hành mall riêng để buôn bán các mặt hàng.',
                          'Quản lý giá cả, chương trình khuyến mãi, doanh thu của cửa hàng.',
                          'Hỗ trợ mở các chương trình khuyến mãi dành riêng cho mall hàng tháng từ YouTex.',
                        ],
                      ),
                      _buildBenefitItem(
                        'Hỗ trợ PR & Marketing:',
                        [
                          'Quản lý chiến dịch marketing hàng tháng cho mall.',
                          'Viết nội dung quảng cáo cho các chiến dịch mall.',
                          'Lưu trữ và đăng tối đa 10 bài PR/tháng cho mall, do team marketing viết.',
                          '500k/bài PR từ bài thứ 11 trở đi.',
                        ],
                      ),
                      _buildBenefitItem(
                        'Bảo hiểm đơn hàng - Buff Youtex:',
                        [
                          'Đảm bảo an toàn cho các giao dịch qua mall.',
                        ],
                      ),
                      _buildBenefitItem(
                        'Xây dựng uy tín doanh nghiệp - Dấu chuẩn Youtex:',
                        [
                          'Xây dựng uy tín với thông tin doanh nghiệp, thế mạnh, hình ảnh được truyền thông rộng rãi.',
                          'Có hội nhận biểu tượng 5* nếu đạt chuẩn.',
                          'Hỗ trợ doanh nghiệp đạt chuẩn TCVN.',
                        ],
                      ),
                      _buildBenefitItem(
                        'Quyền lợi ưu tiên trong sự kiện:',
                        [
                          'Nhận ưu tiên trong các sự kiện và chương trình khuyến mãi đặc biệt từ YouTex.',
                        ],
                      ),
                      _buildBenefitItem(
                        'Tài khoản quản lý cho Mall:',
                        [
                          'Tài khoản riêng dành cho việc quản lý mall.',
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Đóng'),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

Widget _buildBenefitItem(String title, List<String> details) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.star_border, color: Colors.amber, size: 24),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              ...details.map((detail) => Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(detail),
              )),
            ],
          ),
        ),
      ],
    ),
  );
}
