import 'package:flutter/material.dart';
import 'package:timelines/timelines.dart';
import 'package:ui_youtex/core/size/size.dart';
import 'package:ui_youtex/core/themes/theme_extensions.dart';

import '../../../../../core/colors/color.dart';
class ColorTransitionPage extends StatefulWidget {
  const ColorTransitionPage({super.key});

  @override
  _ColorTransitionPageState createState() => _ColorTransitionPageState();
}

class _ColorTransitionPageState extends State<ColorTransitionPage> {
  double _offset = 0.0;

  @override
  void initState() {
    super.initState();
    _startAnimation();
  }

  void _startAnimation() {
    Future.delayed(const Duration(milliseconds: 5), () {
      setState(() {
        _offset = 1.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Scaffold(
        backgroundColor: Colors.transparent, // Đặt nền trong suốt
        body: GestureDetector(
          onTap: () {}, // Chặn sự kiện tap trong trang
          child: Stack(
            children: [
              AnimatedContainer(
                duration: const Duration(seconds: 1),
                transform: Matrix4.translationValues(
                    0, MediaQuery.of(context).size.height * (1 - _offset), 0),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.8,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20.0),
                    ),
                  ),
                  child: const TimelineExample(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class TimelineExample extends StatelessWidget {
  const TimelineExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding:const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(18),topRight: Radius.circular(18)),
          gradient: LinearGradient(
            colors: [
              Color(0xFF6DA7FF),
              Color(0xFFDAF5FF),
              Color(0xFFE2EEF3),
            ],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        child: Column(
          children: [
            Container(
              height: 5,
              margin: EdgeInsets.symmetric(horizontal: context.width*0.3),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Styles.nearPrimary,
                  boxShadow: [
                    BoxShadow(
                        color:const Color(0xff000000).withOpacity(0.25),
                        offset:const Offset(0, 4),
                        blurRadius: 4
                    )
                  ]
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.local_shipping_outlined, color: Styles.nearPrimary),
                      const SizedBox(width: 8),
                      Text('Mã vận đơn', style: context.theme.textTheme.headlineSmall,),
                    ],
                  ),
                  Text('GHNVN0857497245', style: context.theme.textTheme.headlineSmall,),
                ],
              ),
            ),
            Divider(color: const Color(0xff000000).withOpacity(0.16),thickness: 1,endIndent: context.width*0.15,indent: context.width*0.15,),
           const SizedBox(height: 10,),
            Expanded(
              child: Timeline.tileBuilder(
                theme: TimelineThemeData(
                  nodePosition: 0,
                  indicatorPosition: 0,
                  connectorTheme: const ConnectorThemeData(
                    color: Colors.blue,
                    thickness: 2.5,
                  ),
                ),
                builder: TimelineTileBuilder.connected(
                  indicatorBuilder: (context, index) => _buildIndicator(index),
                  connectorBuilder: (context, index, _) => const SolidLineConnector(
                    color: Styles.nearPrimary,
                  ),
                  itemCount: 7,
                  contentsBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.only(left: 8.0, bottom: 24.0), // Điều chỉnh lề trái
                    child: _buildTimelineContent(context,index),
                  ),
                ),
              ),
            ),
          ],
        )
    );
  }

  // Tạo các biểu tượng cho từng trạng thái
  Widget _buildIndicator(int index) {
    final icons = [
      Icons.gif_box_outlined,          // Giao hàng thành công
      Icons.local_shipping_outlined,     // Đang giao đến
      Icons.storefront,              // Rời kho
      Icons.store_mall_directory_outlined, // Đến kho
      Icons.local_shipping_outlined,     // Đang chờ vận chuyển
      Icons.check_circle_outline,       // Đã xác nhận
      Icons.shopping_cart_outlined,      // Đặt hàng thành công
    ];

    return DotIndicator(
      size: 36.0,
      color: const Color(0xffAAD5F5),
      child: Icon(
        icons[index],
        color: Styles.nearPrimary,
      ),
    );
  }

  // Tạo nội dung cho mỗi mục trong dòng thời gian
  Widget _buildTimelineContent(BuildContext context,int index) {
    final titles = [
      'Giao hàng thành công',
      'Đơn hàng đang được giao đến bạn',
      'Đơn hàng đã rời kho Củ Chi',
      'Đơn hàng đã đến kho Củ Chi',
      'Đơn hàng đang chờ vận chuyển',
      'Đơn hàng đã được xác nhận',
      'Đặt hàng thành công',
    ];

    final times = [
      '10/10/2024 16:06',
      '10/10/2024 11:11',
      '09/10/2024 21:53',
      '09/10/2024 16:10',
      '08/10/2024 16:06',
      '07/10/2024 16:06',
      '06/10/2024 16:06',
    ];

    return Row(
      children: [
        const SizedBox(width: 48.0), // Điều chỉnh khoảng cách giữa icon và nội dung
        Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Căn chỉnh nội dung text sang trái
          children: [
            Text(
              titles[index],
              style: context.theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,color:Styles.nearPrimary),
            ),
            const SizedBox(height: 4.0),
            Text(
              times[index],
              style: context.theme.textTheme.titleMedium?.copyWith(
                  color: const Color(0xff4E4E4E)),
            ),
          ],
        ),
      ],
    );
  }
}
