import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_youtex/core/size/size.dart';
import 'package:ui_youtex/core/themes/theme_extensions.dart';

import '../../../bloc/login_bloc/login_bloc.dart';
import '../../../core/assets.dart';
import 'detail_article.dart';
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // final token = context.read<LoginBloc>().token;
    return Scaffold(
      appBar: AppBar(
        leading: null,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Image.asset(
              Asset.bgLogo,
              height: 40,
            ),
          ],
        ),
        // actions: [
        //   CircleAvatar(backgroundColor: Colors.grey.shade300,child: const Icon(Icons.search)),
        //   const SizedBox(width: 10),
        //   CircleAvatar(backgroundColor: Colors.grey.shade300,child: const Icon(Icons.notifications_none)),
        //   const SizedBox(width: 10),
        // ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Container(
            margin:const EdgeInsets.symmetric(vertical: 10),
            height: 150,
            width: context.width,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              image: DecorationImage(image: AssetImage(Asset.bgSlider),fit: BoxFit.fill)
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Text(
                'Doanh nghiệp nổi bật',
                style: context.theme.textTheme.headlineLarge,
              ),
              const SizedBox(height: 10),
              Container(
                height: 100,
                padding: const EdgeInsets.all(10),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    color: Colors.grey.shade100,
                    boxShadow: const [
                      BoxShadow(offset: Offset(4, 4),color: Colors.grey,blurRadius: 6)
                    ]
                ),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: const [
                    FeaturedCompanyCard(
                      imageUrl: Asset.bgCustomer1,
                      title: 'Vinatex',
                    ),
                    FeaturedCompanyCard(
                      imageUrl: Asset.bgCustomer2,
                      title: 'Viet Thang',
                    ),
                    FeaturedCompanyCard(
                      imageUrl: Asset.bgCustomer3,
                      title: 'Viet Tien',
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Section 2: "Thương hiệu dệt may Việt 2024"
          const Card(
            child: Column(
              children: [
                PostCard(
                  imageUrl: Asset.bgCustomer4,
                  title: 'THƯƠNG HIỆU DỆT MAY VIỆT 2024',
                  description: '..........................................................\n16:00 Thứ Bảy, ngày 12 tháng 10 năm 2024',
                  isRow: true,
                ),
                SizedBox(height: 10),
                PostCard(
                  imageUrl: Asset.bgCustomer5,
                  title: 'KHAI TRƯƠNG CHI NHÁNH THỨ 10',
                  description: '......................................................................................................................................................................\n16:00 Thứ Bảy, ngày 12 tháng 10 năm 2024',
                  isRow: false,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          // Section 4: "Bài đăng nổi bật"
          const Text(
            'Bài đăng nổi bật',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          const SizedBox(height: 10),
          const HighlightedPostCard(
            imageUrl: Asset.bgCustomer4,
            title: 'KỶ NIỆM 10 NĂM THÀNH LẬP HẢI ANH',
            description: 'Kỷ niệm 10 năm của công ty...',
            actions: ['Xem thêm', 'Nhận quà'],
          ),
          const SizedBox(height: 10),
          const HighlightedPostCard(
            imageUrl: Asset.bgCustomer4,
            title: 'CHUNG TAY CÙNG VINID XÂY TRƯỜNG MỚI',
            description: 'Cùng chung tay với VinID để xây trường mới...',
            actions: ['Xem thêm', 'Nhận quà'],
          ),
        ],
      ),
    );
  }
}

class FeaturedCompanyCard extends StatelessWidget {
  final String imageUrl;
  final String title;

  const FeaturedCompanyCard({super.key, required this.imageUrl, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(offset: Offset(4, 4),color: Colors.grey,blurRadius: 6)
                  ]
              ), child: Stack(
                  children: [
                   CircleAvatar(
                     radius: 20,
                     backgroundImage: AssetImage(imageUrl),
                   ),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child: Image.asset(Asset.iconSec,fit: BoxFit.contain,)
                    )
                  ],
                )),
          // iconSec
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class PostCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;
  final bool isRow;

  const PostCard({super.key, required this.imageUrl, required this.title, required this.description,required this.isRow});

  @override
  Widget build(BuildContext context) {
    return isRow!=true?Padding(
      padding: const EdgeInsets.all(16.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const DetailArticle(),));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(imageUrl, fit: BoxFit.contain, height: 150, width: double.infinity),
            Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text(description),
          ],
        ),
      ),
    )
        :Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(imageUrl, fit: BoxFit.contain, height: 150, width: 150),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: 180,child: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
              const SizedBox(height: 10),
              SizedBox(width: 180,child: Text(description)),
            ],
          ),
        ),
      ],
    );
  }
}

class HighlightedPostCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;
  final List<String> actions;

  const HighlightedPostCard({super.key,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(imageUrl, fit: BoxFit.cover, height: 150, width: 150),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(width: 160,child: Text(title,style: context.theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold
                    ),)),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(image: AssetImage(imageUrl),fit: BoxFit.fill),
                              boxShadow: const [
                                BoxShadow(offset: Offset(4, 4),color: Colors.grey,blurRadius: 6)
                              ]
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          children: [
                            SizedBox(
                              width: 130,
                              child: Text("Tập đoàn VinGroup",style: context.theme.textTheme.titleMedium?.copyWith(),),
                            ),
                          ],
                        )
                      ],
                    ),
                    // Row(
                    //   children: actions
                    //       .map(
                    //         (action) => Padding(
                    //       padding: const EdgeInsets.only(right: 8.0),
                    //       child: ElevatedButton(
                    //         onPressed: () {},
                    //         child: Text(action),
                    //       ),
                    //     ),
                    //   )
                    //       .toList(),
                    // )
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(description,style: context.theme.textTheme.titleMedium?.copyWith(),),
          ),
        ],
      ),
    );
  }
}