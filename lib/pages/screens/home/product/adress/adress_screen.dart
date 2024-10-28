import 'package:flutter/material.dart';
import 'package:ui_youtex/core/themes/theme_extensions.dart';

import '../../../../../core/colors/color.dart';
import '../../../../widget_small/custom_button.dart';
import 'adress_add_screen.dart';
class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  _AddressScreenState createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  int _selectedAddress = 0;

  List<Map<String, String>> addresses = [
    {"label": "Nhà riêng", "address": "925 S Chugach St #APT 10, Alaska", "type": "Default"},
    {"label": "Nhà riêng", "address": "925 S Chugach St #APT 10, Alaska", "type": ""},
    {"label": "Công ty", "address": "925 S Chugach St #APT 10, Alaska", "type": "Default"},
    {"label": "Công ty", "address": "925 S Chugach St #APT 10, Alaska", "type": ""},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Styles.blue,
        centerTitle: true,
        leading: InkWell(onTap: () => Navigator.pop(context),child: const Icon(Icons.arrow_back_ios,color: Styles.light,)),
        title: Text('Địa Chỉ',style: context.theme.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.bold,
          color: Styles.light,
        ),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Row(mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Địa chỉ đã thêm',),
              ],
            ),
            // List of Addresses
            Expanded(
              child: ListView.builder(
                itemCount: addresses.length,
                itemBuilder: (context, index) {
                  return AddressItem(
                    label: addresses[index]['label']!,
                    address: addresses[index]['address']!,
                    isSelected: _selectedAddress == index,
                    isDefault: addresses[index]['type'] == "Default",
                    onChanged: () {
                      setState(() {
                        _selectedAddress = index;
                      });
                    },
                  );
                },
              ),
            ),
             // Add New Address Button

             // Save Changes Button
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(borderRadius:BorderRadius.circular(16),border: Border.all( width: 1,color: Styles.grey)),
              child: TextButton.icon(
                onPressed: () {
                  // Handle adding a new card
                },
                icon: const Icon(Icons.add, color: Colors.black87),
                label: Text('Thêm thẻ mới',style: context.theme.textTheme.titleLarge?.copyWith( ),),
              ),
            ),
            const SizedBox(height: 20),
            // Save Button
            InkWell(onTap: () => Navigator.push(context,MaterialPageRoute(builder: (context) =>   const AddAddressScreen(),)),child: const CusButton(text:"Lưu thay đổi",color:Styles.blue)),
          ],
        ),
      ),
    );
  }
}

class AddressItem extends StatelessWidget {
  final String label;
  final String address;
  final bool isSelected;
  final bool isDefault;
  final VoidCallback onChanged;

  const AddressItem({super.key, 
    required this.label,
    required this.address,
    required this.isSelected,
    required this.isDefault,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
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
              activeColor:  Styles.blue,
            ),
          ],
        ),
      ),
    );
  }
}
