import 'package:flutter/material.dart';
import 'package:ui_youtex/core/themes/theme_extensions.dart';
import '../../../../core/assets.dart';
import '../../../../core/colors/color.dart';
import 'delivery_information/delivery_information.dart';
class HistoryOrder extends StatelessWidget {
  const HistoryOrder({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thông tin đơn hàng',style: context.theme.textTheme.headlineLarge?.copyWith(
            color: Colors.white,fontWeight: FontWeight.bold
        ),),
        leading: const InkWell(
          child: Icon(Icons.arrow_back,color: Colors.white,),
        ),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 4,
              shadowColor: Colors.grey.withOpacity(0.5),
              color: Styles.nearBlue,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.local_shipping_outlined, color:Color(0xff113A71)),
                        const SizedBox(width: 8),
                        Text('Thông tin vận chuyển',style: context.theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        )),
                        const Spacer(),
                        TextButton(
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              builder: (BuildContext context) {
                                return const FractionallySizedBox(
                                  heightFactor: 0.8,
                                  child: TimelineExample(),
                                );
                              },
                            );
                          },
                          child: Text('Xem thêm',style: context.theme.textTheme.titleMedium?.copyWith(
                              color: Colors.blue
                          ),),
                        ),
                      ],
                    ),
                    Text('Giao hàng nhanh - GHNVN0857497245',style: context.theme.textTheme.titleSmall?.copyWith(
                    )),
                    Text('Giao hàng thành công',style: context.theme.textTheme.titleMedium?.copyWith(
                        color: Colors.blue
                    )),
                  ],
                ),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 4,
              shadowColor: Colors.grey.withOpacity(0.5),
              color: Styles.nearBlue,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.location_on_outlined, color: Color(0xff113A71)),
                        const SizedBox(width: 8),
                        Text('Thông tin vận chuyển',style: context.theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        )),
                      ],
                    ),
                    Text('(+84) 956875067',style: context.theme.textTheme.titleSmall?.copyWith(
                    )),
                    Text('85A/678, Đường số 8, Linh Trung, Thủ Đức, TP. Hồ Chí Minh',style: context.theme.textTheme.titleSmall?.copyWith(
                    )),
                  ],
                ),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 4,
              shadowColor: Colors.grey.withOpacity(0.5),
              color: Styles.nearBlue,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 2,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            const Divider(color: Color(0xffE7E7E7),),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 85,
                                  height: 85,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(19),
                                      image: const DecorationImage(image: AssetImage(Asset.bgImageProduct,),
                                        fit: BoxFit.cover,)
                                  ),
                                ),
                                Container(
                                  height: 85,
                                  margin: const EdgeInsets.only(left: 10),
                                  decoration: const BoxDecoration(
                                    border: Border(right: BorderSide(color: Color(0xffE7E7E7),width: 1,)),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Text('Vải Cotton May Áo Phông'
                                          ,style: context.theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text('C410, Màu hồng'
                                            ,style: context.theme.textTheme.titleMedium,
                                          ),
                                          const Spacer(),
                                          Text('114.000đ'
                                            ,style: context.theme.textTheme.titleMedium,
                                          ),
                                        ],
                                      ),
                                      Text('X5'
                                        ,style: context.theme.textTheme.titleMedium,
                                      ),
                                      Text('570.000đ'
                                        ,style: context.theme.textTheme.titleMedium,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                    const Divider(color: Color(0xffE7E7E7),),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Tổng tiền hàng',
                          style: context.theme.textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.w500),),
                        Text('1.140.000đ',
                            style: context.theme.textTheme.titleMedium),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Phí vận chuyển',
                          style: context.theme.textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.w500),),
                        Text('30.000đ',
                            style: context.theme.textTheme.titleMedium),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Ưu đãi',
                          style: context.theme.textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.w500),),
                        Text('-22.000đ',
                            style: context.theme.textTheme.titleMedium),
                      ],
                    ),
                    const Divider(color: Color(0xffE7E7E7),),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Thành tiền',
                          style: context.theme.textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold),),
                        Text('1.140.000đ',
                            style: context.theme.textTheme.headlineSmall?.copyWith(
                                color: Colors.blue
                            )),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 4,
              shadowColor: Colors.grey.withOpacity(0.5),
              color: Styles.nearBlue,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Image.asset(Asset.iconHand),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Phương thức thanh toán',style: context.theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        )),
                        Text('Thanh toán khi nhận hàng',style: context.theme.textTheme.titleSmall?.copyWith(
                        )),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              color: Styles.nearBlue,
              elevation: 4,
              shadowColor: Colors.grey.withOpacity(0.5),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text('Mã đơn hàng',style: context.theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        )),
                        const Spacer(),
                        Text('357902AKM7690',style: context.theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        )),
                      ],
                    ),
                    const SizedBox(height: 10,),
                    Row(
                      children: [
                        Text('Thời gian đặt hàng',style: context.theme.textTheme.titleMedium?.copyWith(
                        )),
                        const Spacer(),
                        Text('06/10/2024  16:06',style: context.theme.textTheme.titleMedium?.copyWith(
                        )),
                      ],
                    ),
                    const SizedBox(height: 5,),
                    Row(
                      children: [
                        Text('Thời gian giao hàng ',style: context.theme.textTheme.titleMedium?.copyWith(
                        )),
                        const Spacer(),
                        Text('06/10/2024  16:06',style: context.theme.textTheme.titleMedium?.copyWith(
                        )),
                      ],
                    ),
                    const SizedBox(height: 5,),
                    Row(
                      children: [
                        Text('Thời gian hoàn thành đơn hàng',style: context.theme.textTheme.titleMedium?.copyWith(
                        )),
                        const Spacer(),
                        Text('06/10/2024  16:06',style: context.theme.textTheme.titleMedium?.copyWith(
                        )),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}