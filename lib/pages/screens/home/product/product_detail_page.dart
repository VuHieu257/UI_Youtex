import 'package:flutter/material.dart';
import 'package:ui_youtex/core/size/size.dart';
import 'package:ui_youtex/core/themes/theme_extensions.dart';

import '../../../../core/assets.dart';
import '../../../../core/colors/color.dart';
import '../../shopping_cart_page/shopping_cart_page.dart';
class ProductDetailPage extends StatelessWidget {
  final Map<String, dynamic> product;

  const ProductDetailPage({super.key,
    required this.product
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Styles.blue,
        centerTitle: true,
        leading: InkWell(onTap: () => Navigator.pop(context),child: const Icon(Icons.arrow_back_ios,color: Styles.light,)),
        title: Text('Chi tiết sản phẩm',style: context.theme.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.bold,
          color: Styles.light,
        ),),
        actions: [
          const SizedBox(width: 10),
          IconButton(
            icon:const Icon(Icons.shopping_cart_outlined,color: Styles.light,),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ShoppingCartPage(),
                  ));
                          },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image
              Container(
                height: context.height*0.4,
                width: context.width*0.9,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    // image: const DecorationImage(image: AssetImage(Asset.bgImageProduct,
                    image: DecorationImage(image: AssetImage( product['image'],
                    ),fit: BoxFit.cover,)
                ),
              ),
              const SizedBox(height: 16),

              // Product Title and Price
              Text(
                product['name'],
                style: context.theme.textTheme.headlineLarge?.copyWith(
                  fontSize: 24,
                ),
                // style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                '${product['price']}đ',
                style: context.theme.textTheme.headlineMedium?.copyWith(
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 8),
              // Ratings and Review Count
              Row(
                children: [
                  const Icon(Icons.star, color: Colors.orange, size: 16),
                  const Icon(Icons.star, color: Colors.orange, size: 16),
                  const Icon(Icons.star, color: Colors.orange, size: 16),
                  const Icon(Icons.star, color: Colors.orange, size: 16),
                  const Icon(Icons.star_half, color: Colors.orange, size: 16),
                  const SizedBox(width: 8),
                  Text('4.7 (143 Reviews)',
                    style: context.theme.textTheme.titleSmall?.copyWith(
                    ),),
                  const SizedBox(width: 8),
                  Text('Đã bán: 63' ,style: context.theme.textTheme.titleSmall?.copyWith(
                  ),),
                ],
              ),
              const SizedBox(height: 16),

              // User Information
              Row(
                children: [
                  const CircleAvatar(
                    backgroundImage: AssetImage(
                        Asset.bgImageAvatar), // Replace with user's image
                    radius: 25,
                  ),
                  const SizedBox(width: 10),
                  Text('Phan Hiền',style: context.theme.textTheme.titleSmall?.copyWith(
                  ),),
                  const Spacer(),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 12),
                    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                    decoration: BoxDecoration(
                      color: Styles.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child:  Text('Theo dõi',style: context.theme.textTheme.titleSmall?.copyWith(
                      color: Colors.white,
                    ),),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Styles.blue)
                    ),
                    child:  Text('Nhắn tin',style: context.theme.textTheme.titleSmall?.copyWith(
                      color: Colors.black87,
                    ),),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Quantity Selector
              Row(
                children: [
                  Text('Số lượng',style: context.theme.textTheme.titleMedium?.copyWith(),),
                  const Spacer(),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(width: 1,color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: () {},
                        ),
                        Text('1',style: context.theme.textTheme.titleMedium?.copyWith(),),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),

                ],
              ),
              // Product Description
              Text('Màu sắc',style: context.theme.textTheme.titleMedium?.copyWith(),),
              Wrap(
                children: [
                  customColor(context,"xanh nayy",true),
                  customColor(context,"Xanh Lá Mạ",false),
                  customColor(context,"Xanh Lá Mạ",false),
                  customColor(context,"Xanh Lá Mạ",false),
                  customColor(context,"Xanh Lá Mạ",false),
                  customColor(context,"Xanh Lá Mạ",false),
                ],
              ),
              Text(
                'Giới thiệu về sản phẩm này'
                ,style: context.theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold
              ),
                // style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                'Máy khâu bao Kachi KC9-200-2 đang cầm tay được nhiều người ưa chuộng '
                    'tín dùng, máy hoạt động với tốc độ cao, thực hiện công việc nhanh và hiệu quả.'
                    'Máy khâu bao  Kachi KC9-200-2 dạng cầm tay được nhiều người ưa chuộng tin dùng, máy hoạt động với tốc độ cao, thực hiện công việc nhanh chóng hiệu quả.Máy khâu bao bì cầm tay Kachi KC9-200-2 được sản xuất có sự cải tiến mới, bổ sung thêm một số tính năng nổi bật nhằm mang lại sự hài lòng cao cho người tiêu dùng.'
                    'Trọng lượng máy nhỏ gọn chỉ 2.8kg, kết cấu đơn giản, tốc độ khâu của kim từ 1500-1700 lần kim/phút, hiệu suất làm việc tốt, giúp giảm cường độ làm việc của người dùng.'
                    'Máy may bao  Kachi KC9-200-2 được ứng dụng rộng rãi trong việc đóng gói bao bì cho các sản phẩm như ngũ cốc, đường, chè, muối, mỏ, than đá,... thuận tiện cho vận chuyển hàng hóa đến nhiều nơi mà không lo ảnh hưởng đến chất lượng sản phẩm. Máy hoạt động ổn định, động cơ chạy êm ái, ít phát ra tiếng ồn tạo cảm giác thoải mái khi sử dụng cũng như không làm ảnh hưởng đến mọi người xung quanh. Máy được làm từ vật liệu thép không gỉ, chịu được nhiệt tốt, chống ăn mòn giúp máy hoạt động tốt trong mọi điều kiện làm việc.'
                    'rong quá trình sử dụng máy khâu bao  Kachi KC9-200-2 sẽ không tránh khỏi việc máy bị bám bụi bẩn, trầy xước hay va đập, chính vì những nguyên nhân đó sẽ làm ảnh hưởng đến tuổi thọ máy nghiêm trọng.'
                    'Để bảo đảm cho máy hoạt động một cách tốt nhất, bạn nên đặt máy ở nơi khô ráo, sạch sẽ, dùng khăn phủ lên máy khi không sử dụng.'
                    'Nên để máy lên tấm vải dày hay một vận dụng có độ êm để tránh máy bị trầy xước trong quá trình hoạt động máy.'
                    'Nên thường xuyên kiểm tra các bộ phận máy xem thiết bị có bị hư hỏng, cần phải bảo dưỡng sửa chữa hay không.'
                    'Do hoạt động ở nhiều môi trường khác nhau, máy may bao cầm tay sẽ không tránh khỏi việc bị bụi bẩn bám vào nên bạn hãy thường xuyên vệ sinh, lau chùi để máy luôn ổn định, sạch đẹp.',
                style: context.theme.textTheme.headlineSmall?.copyWith(
                ),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 16),

              // Add to Cart and Buy Now Buttons
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        color: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Styles.blue)
              ),
              child:  Row(
                children: [
                  const Icon(Icons.shopping_cart_outlined,color: Styles.blue),
                  Text('Thêm vào Giỏ hàng',style: context.theme.textTheme.titleSmall?.copyWith(
                      color: Styles.blue
                  ),),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 14),
              decoration: BoxDecoration(
                color: Styles.blue,
                borderRadius: BorderRadius.circular(10),
                // border: Border.all(color: Styles.blue)
              ),
              child:  Row(
                children: [
                  Text('Mua ngay',style: context.theme.textTheme.titleSmall?.copyWith(
                      color: Styles.light
                  ),),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  Container customColor(BuildContext context,String title,bool isCheck){
    return  Container(
      margin: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 3),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(37),color:isCheck?Styles.blue:Styles.greyLight),
      child: Text(title,style: context.theme.textTheme.titleSmall?.copyWith(color: isCheck?Styles.light:Styles.dark),),
    );
  }
}
