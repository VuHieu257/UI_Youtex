import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:ui_youtex/core/themes/theme_extensions.dart';

import '../../../../../bloc/address_bloc/address_bloc.dart';
import '../../../../../core/colors/color.dart';
import '../../../../widget_small/custom_button.dart';
import '../../../user/user_profile/user_profile_settings.dart';
import 'adress_add_screen.dart';

// class AddressScreen extends StatefulWidget {
//   const AddressScreen({super.key});
//
//   @override
//   _AddressScreenState createState() => _AddressScreenState();
// }
//
// class _AddressScreenState extends State<AddressScreen> {
//   int _selectedAddress = 0;
//
//   List<Map<String, String>> addresses = [
//     {
//       "label": "Nhà riêng",
//       "address": "925 S Chugach St #APT 10, Alaska",
//       "type": "Default"
//     },
//     {
//       "label": "Nhà riêng",
//       "address": "925 S Chugach St #APT 10, Alaska",
//       "type": ""
//     },
//     {
//       "label": "Công ty",
//       "address": "925 S Chugach St #APT 10, Alaska",
//       "type": "Default"
//     },
//     {
//       "label": "Công ty",
//       "address": "925 S Chugach St #APT 10, Alaska",
//       "type": ""
//     },
//   ];
//
//   @override
//   void initState() {
//     context.read<AddressBloc>().add(FetchAddresses());
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Styles.blue,
//         centerTitle: true,
//         leading: InkWell(
//             onTap: () => Navigator.pop(context),
//             child: const Icon(
//               Icons.arrow_back_ios,
//               color: Styles.light,
//             )),
//         title: Text(
//           'Địa Chỉ',
//           style: context.theme.textTheme.titleMedium?.copyWith(
//             fontWeight: FontWeight.bold,
//             color: Styles.light,
//           ),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             const Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 Text(
//                   'Địa chỉ đã thêm',
//                 ),
//               ],
//             ),
//
//             Expanded(
//               child: BlocBuilder<AddressBloc, AddressState>(
//                 builder: (context, state) {
//                   if (state is AddressLoading) {
//                     return const Center(child: CircularProgressIndicator());
//                   } else if (state is AddressLoaded) {
//                     return ListView.builder(
//                       itemCount: state.addresses.length,
//                       itemBuilder: (context, index) {
//                         final address = state.addresses[index];
//                         return GestureDetector(
//                           onLongPress: () {
//                             _showDeleteConfirmationDialog(context,address.id);
//                           },
//                           child: AddressItem(
//                             label: address.name,
//                             address: address.address,
//                             isSelected: _selectedAddress == index,
//                             isDefault: address.isDefault == 1,
//                             onChanged: () {
//                               setState(() {
//                                 _selectedAddress = index;
//                               });
//                             },
//                           ),
//                         );
//                       },
//                     );
//                   } else if (state is AddressError) {
//                     return Center(child: Text(state.message));
//                   }
//                   return const Center(child: Text('No addresses found.'));
//                 },
//               ),
//             ),
//
//             Container(
//               alignment: Alignment.center,
//               padding: const EdgeInsets.all(5),
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(16),
//                   border: Border.all(width: 1, color: Styles.grey)),
//               child: TextButton.icon(
//                 onPressed: () {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => const AddAddressScreen(),
//                       ));
//                 },
//                 icon: const Icon(Icons.add, color: Colors.black87),
//                 label: Text(
//                   'Thêm địa chỉ mới',
//                   style: context.theme.textTheme.titleLarge?.copyWith(),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//             // Save Button
//             InkWell(
//                 onTap: () => Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => const AddAddressScreen(),
//                     )),
//                 child:
//                     const CusButton(text: "Lưu thay đổi", color: Styles.blue)),
//           ],
//         ),
//       ),
//     );
//   }
// }

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  _AddressScreenState createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  int _selectedAddress = -1; // Track the selected address

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Styles.blue,
        centerTitle: true,
        leading: InkWell(
            onTap: () => Navigator.push(context,MaterialPageRoute(builder: (context) => const AccountSettingsScreen(),)),
            child: const Icon(
              Icons.arrow_back_ios,
              color: Styles.light,
            )),
        title: Text(
          'Địa Chỉ',
          style: context.theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: Styles.light,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Địa chỉ đã thêm',
                ),
              ],
            ),

            Expanded(
              child: BlocProvider(
                create: (context) => AddressBloc()..add(FetchAddresses()),
                child: BlocBuilder<AddressBloc, AddressState>(
                  builder: (context, state) {
                    if (state is AddressLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is AddressLoaded) {
                      return ListView.builder(
                        itemCount: state.addresses.length,
                        itemBuilder: (context, index) {
                          final address = state.addresses[index];
                          return GestureDetector(
                            onLongPress: () {
                              _showDeleteConfirmationDialog(context, address.id);
                            },
                            child: AddressItem(
                              label: address.name,
                              address: address.address,
                              isSelected: _selectedAddress == index,
                              isDefault: address.isDefault == 1,
                              onChanged: () {
                                setState(() {
                                  _selectedAddress = index;
                                });
                              },
                            ),
                          );
                        },
                      );
                    } else if (state is AddressError) {
                      return Center(child: Text(state.message));
                    }
                    return const Center(child: Text('No addresses found.'));
                  },
                ),
              ),
            ),

            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(width: 1, color: Styles.grey)),
              child: TextButton.icon(
                onPressed: () async {
                  // Navigate to the AddAddressScreen and wait for the result
                  // AddressScreen
                  final result = await Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddAddressScreen(),
                    ),
                    (route) => false,
                  );

                  if (result == true) {
                    // Refresh addresses by adding FetchAddresses event
                    context.read<AddressBloc>().add(FetchAddresses());
                  }
                },
                icon: const Icon(Icons.add, color: Colors.black87),
                label: Text(
                  'Thêm địa chỉ mới',
                  style: context.theme.textTheme.titleLarge?.copyWith(),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Save Button
            InkWell(
                onTap: () {
                  Navigator.pop(
                    context,
                  );
                },
                child: const CusButton(text: "Lưu thay đổi", color: Styles.blue)),
          ],
        ),
      ),
    );
  }
}

void _showDeleteConfirmationDialog(BuildContext context,int id) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Xác nhận xóa"),
        content: const Text("Bạn có chắc chắn muốn xóa không?"),
        actions: <Widget>[
          TextButton(
            child: const Text("Hủy"),
            onPressed: () {
              Navigator.of(context).pop(); // Đóng hộp thoại
            },
          ),
          TextButton(
            child: const Text("Xóa"),
            onPressed: () {
              context
                  .read<AddressBloc>()
                  .add(DeleteAddress(id));
              context.read<AddressBloc>().add(FetchAddresses());
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

class AddressItem extends StatelessWidget {
  final String label;
  final String address;
  final bool isSelected;
  final bool isDefault;
  final VoidCallback onChanged;

  const AddressItem({
    super.key,
    required this.label,
    required this.address,
    required this.isSelected,
    required this.isDefault,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: const Color(0xffF3F3F3),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 4,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        leading: const Icon(Icons.location_on, color: Styles.blue),
        title: Text(label),
        subtitle: Text(
          address,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isDefault)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'Default',
                  style: TextStyle(fontSize: 12),
                ),
              ),
            Radio(
              value: true,
              groupValue: isSelected,
              onChanged: (_) => onChanged(),
              activeColor: Styles.blue,
            ),
          ],
        ),
      ),
    );
  }
}
