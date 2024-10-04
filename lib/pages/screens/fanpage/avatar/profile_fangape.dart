import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ui_youtex/core/assets.dart';
import 'package:ui_youtex/core/themes/theme_extensions.dart';
import 'package:ui_youtex/pages/screens/fanpage/avatar/Setting/SettingsPage.dart';

import '../../../../core/colors/color.dart';

class ProfileFanpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4, // Bốn tab: Bài viết, Giới thiệu, Ảnh, Video
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Styles.blue,
          centerTitle: true,
        leading: InkWell(onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back_ios, color: Styles.light,)),

          title: Text(
            'Cài Đặt Trang', style: context.theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: Styles.light,
          ),),          actions: [
            IconButton(
              icon: Icon(Icons.edit),
              color: Styles.light,

              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.settings),
              color: Styles.light,

              onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context)=>SettingsPage()),);},
            ),
          ],
        ),

        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                clipBehavior: Clip.none, // Cho phép phần tử con không bị cắt
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    Asset.bg_ava,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    left: 20,
                    bottom: -50,
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: AssetImage(Asset.bg_ava_), // Ảnh đại diện
                    ),
                  ),
                ],
              ),
              SizedBox(height: 60), // Khoảng cách giữa ảnh đại diện và thông tin
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Youtextile',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '119 người theo dõi',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Cung cấp đa dạng các loại vải trên thị trường.',
                      style: TextStyle(fontSize: 14, color: Colors.black),
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start  ,
                      children: [
                        ElevatedButton.icon(
                          icon: Icon(Icons.notifications,size: 18,color: Styles.grey,),
                          label: Text('Đang theo dõi',style:TextStyle(color: Styles.grey),),
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[200], // Nút màu xám nhạt
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8), // Bo góc vuông
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        OutlinedButton.icon(
                          icon: Icon(Icons.chat, size: 18,color: Styles.light,),
                          label: Text('Nhắn tin',style:TextStyle(color: Styles.light),),

                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Styles.blue,

                            side: BorderSide(color: Styles.light),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8), // Bo góc vuông
                            ),
                          ),

                        ),
                        SizedBox(width: 10),
                        IconButton(
                          icon: Icon(Icons.more_horiz),
                          onPressed: () {},
                        ),
                      ],
                    ),
                    SizedBox(height: 16)
                  ],
                ),
              ),
              TabBar(
                indicatorColor: Colors.blue,
                labelColor: Colors.blue,
                unselectedLabelColor: Colors.grey,
                tabs: [
                  Tab(text: 'Bài viết'),
                  Tab(text: 'Giới thiệu'),
                  Tab(text: 'Ảnh'),
                  Tab(text: 'Video'),
                ],
              ),
              Container(
                height: 400, // Chiều cao của ListView
                child: TabBarView(
                  children: [
                    // Tab Bài viết
                    ListView.builder(
                      itemCount: 5, // Số lượng bài viết giả định
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                              'https://link_to_post_image.jpg', // Ảnh bài viết
                            ),
                          ),
                          title: Text('Courtney Henry'),
                          subtitle: Text('Lorem ipsum dolor sit amet...'),
                          trailing: Icon(Icons.more_horiz),
                        );
                      },
                    ),
                    // Tab Giới thiệu
// Tab Giới thiệu
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Mô tả',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Icon(Icons.store, size: 24),
                                SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    'Cung cấp đa dạng các loại vải trên thị trường',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Text(
                              'Thông tin liên hệ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Icon(Icons.location_on, size: 24),
                                SizedBox(width: 8),
                                Text(
                                  'Gia Lâm, Hà Nội',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Icon(Icons.phone, size: 24),
                                SizedBox(width: 8),
                                Text(
                                  '0123456789',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Text(
                              'Thông tin cơ bản',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            // Add more information under "Thông tin cơ bản" if needed
                          ],
                        ),
                      ),
                    ),                    // Tab Ảnh
                    Center(child: Text('Thư viện ảnh.')),
                    // Tab Video
                    Center(child: Text('Thư viện video.')),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}