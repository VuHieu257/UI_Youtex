import 'package:flutter/material.dart';
import 'package:ui_youtex/core/size/size.dart';
import 'package:ui_youtex/core/themes/theme_extensions.dart';

import '../../../../core/assets.dart';
import '../../../widget_small/showdialog/showdialog.dart';

class GroupChatSettings extends StatelessWidget {
  final String name;

  const GroupChatSettings({super.key, required this.name});

  // void _showMemberApproval(BuildContext context) {
  //   showModalBottomSheet(
  //     context: context,
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
  //     ),
  //     builder: (BuildContext context) {
  //       return Padding(
  //         padding: const EdgeInsets.all(16.0),
  //         child: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Center(
  //               child: Container(
  //                 width: 40,
  //                 height: 5,
  //                 decoration: BoxDecoration(
  //                   color: Colors.grey[300],
  //                   borderRadius: BorderRadius.circular(10),
  //                 ),
  //               ),
  //             ),
  //             SizedBox(height: 16),
  //             Text(
  //               'Duyệt thành viên',
  //               style: TextStyle(
  //                 fontSize: 24,
  //                 fontWeight: FontWeight.bold,
  //               ),
  //               textAlign: TextAlign.center,
  //             ),
  //             SizedBox(height: 16),
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 Flexible(
  //                   child: Text(
  //                     'Bất kỳ ai có link này đều có thể tham gia nhóm',
  //                     style: TextStyle(fontSize: 16),
  //                   ),
  //                 ),
  //                 Switch(
  //                   value: true, // Initially on
  //                   onChanged: (value) {
  //                     // Add your toggle logic here
  //                   },
  //                   activeColor: Colors.red,
  //                 ),
  //               ],
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }
  // void _showMemberApproval(BuildContext context) {
  //   showModalBottomSheet(
  //     context: context,
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
  //     ),
  //     builder: (BuildContext context) {
  //       // Use StatefulBuilder to manage the state of the Switch
  //       return StatefulBuilder(
  //         builder: (BuildContext context, StateSetter setState) {
  //           bool isSwitched = true; // Initially on
  //
  //           return Padding(
  //             padding: const EdgeInsets.all(16.0),
  //             child: Column(
  //               mainAxisSize: MainAxisSize.min,
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Center(
  //                   child: Container(
  //                     width: 40,
  //                     height: 5,
  //                     decoration: BoxDecoration(
  //                       color: Colors.grey[300],
  //                       borderRadius: BorderRadius.circular(10),
  //                     ),
  //                   ),
  //                 ),
  //                 SizedBox(height: 16),
  //                 Text(
  //                   'Duyệt thành viên',
  //                   style: TextStyle(
  //                     fontSize: 24,
  //                     fontWeight: FontWeight.bold,
  //                   ),
  //                   textAlign: TextAlign.center,
  //                 ),
  //                 SizedBox(height: 16),
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   children: [
  //                     const Flexible(
  //                       child: Text(
  //                         'Bất kỳ ai có link này đều có thể tham gia nhóm',
  //                         style: TextStyle(fontSize: 16),
  //                       ),
  //                     ),
  //                     Switch(
  //                       value: isSwitched,
  //                       onChanged: (value) {
  //                         // Update the state of the switch using setState
  //                         setState(() {
  //                           isSwitched = value;
  //                         });
  //                       },
  //                       activeColor: Colors.red,
  //                     ),
  //                   ],
  //                 ),
  //               ],
  //             ),
  //           );
  //         },
  //       );
  //     },
  //   );
  // }
  void _showMemberApproval(BuildContext context, String title, String content) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            bool isSwitched = true; // Initially on

            void updateMemberApproval(bool value) {
              print('Switch is now: $value');
            }

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const Divider(),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: context.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                title,
                                style: context.theme.textTheme.titleMedium
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                content,
                                style: context.theme.textTheme.titleMedium,
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        title == "Link tham gia nhóm"
                            ? const Icon(Icons.copy)
                            : Switch(
                                value: isSwitched,
                                onChanged: (value) {
                                  setState(() {
                                    isSwitched = value;
                                  });
                                  updateMemberApproval(value);
                                },
                                activeColor: Colors.white,
                                activeTrackColor: Colors.red,
                              ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
        title: Text(
          'Tùy Chọn',
          style: context.theme.textTheme.headlineSmall
              ?.copyWith(color: Colors.white, fontWeight: FontWeight.w500),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage(Asset.bgImageUser),
                ),
                const SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(name,
                        style: context.theme.textTheme.headlineMedium?.copyWith(
                            color: Colors.black87,
                            fontWeight: FontWeight.bold)),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.grey[200],
                              child: IconButton(
                                icon: const Icon(Icons.search,
                                    color: Colors.black87),
                                onPressed: () {
                                  showFeatureUnavailableDialog(context);
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text("Tìm tin nhắn",
                                style: context.theme.textTheme.titleMedium
                                    ?.copyWith(
                                        color: Colors.black87,
                                        fontWeight: FontWeight.bold))
                          ],
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Column(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.grey[200],
                              child: IconButton(
                                icon: const Icon(Icons.group_add,
                                    color: Colors.black87),
                                onPressed: () {
                                  showFeatureUnavailableDialog(context);
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text("Thêm thành viên",
                                style: context.theme.textTheme.titleMedium
                                    ?.copyWith(
                                        color: Colors.black87,
                                        fontWeight: FontWeight.bold))
                          ],
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Column(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.grey[200],
                              child: IconButton(
                                icon: const Icon(
                                  Icons.notifications_none,
                                  color: Colors.black87,
                                ),
                                onPressed: () {
                                  showFeatureUnavailableDialog(context);
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text("Tắt thông báo",
                                style: context.theme.textTheme.titleMedium
                                    ?.copyWith(
                                        color: Colors.black87,
                                        fontWeight: FontWeight.bold))
                          ],
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),

          const Divider(),

          // Các tuỳ chọn trong List
          Expanded(
            child: ListView(
              children: [
                _buildListItem(
                  context,
                  Icons.image_outlined,
                  'Xem hình ảnh, file và liên kết',
                  onTap: () {
                    showFeatureUnavailableDialog(context);
                  },
                ),
                // _buildListItem(context, Icons.people, 'Xem thành viên (9218)',
                // onTap: () {
                //   showFeatureUnavailableDialog(context);
                // },),
                _buildListItem(
                    context, Icons.report_problem_outlined, 'Báo cáo tin nhắn',onTap: () {
                  showFeatureUnavailableDialog(context);
                },),
                _buildListItem(context, Icons.block, 'Chặn',onTap: () {
                  showFeatureUnavailableDialog(context);
                },),
                // _buildListItem(
                //   context,
                //   Icons.approval,
                //   'Phê duyệt thành viên mới',
                //   onTap: () {
                //     // _showMemberApproval(context, "Duyệt thành viên",
                //     //     "Bất kỳ ai có link này đều có thể tham gia nhóm");
                //     showFeatureUnavailableDialog(context);
                //   },
                // ),
                _buildListItem(
                    context, Icons.delete_outline, 'Xoá lịch sử trò chuyện',onTap: () {
                  showFeatureUnavailableDialog(context);

                },),
                // _buildListItem(
                //   context,
                //   Icons.add_link,
                //   'Link tham gia nhóm',
                //   onTap: () {
                //     // _showMemberApproval(context, "Link tham gia nhóm",
                //     //     "Đặt link tham gia nhóm");
                //     showFeatureUnavailableDialog(context);
                //
                //   },
                // ),
                // _buildListItem(context, Icons.exit_to_app, 'Rời nhóm',
                //     color: Colors.red,onTap: () {
                //     showFeatureUnavailableDialog(context);
                //   },),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildListItem(BuildContext context, IconData icon, String title,
      {void Function()? onTap, Color? color}) {
    return ListTile(
      leading: Icon(icon, color: color ?? Colors.black),
      title: Text(title,
          style: context.theme.textTheme.titleMedium
              ?.copyWith(color: Colors.black87, fontWeight: FontWeight.bold)),
      onTap: onTap,
    );
  }
}
