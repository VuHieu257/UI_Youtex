import 'package:flutter/material.dart';
import 'package:ui_youtex/core/themes/theme_extensions.dart';
import 'package:ui_youtex/pages/screens/home/add_success/add_success.dart';
import 'package:ui_youtex/pages/widget_small/appbar/custome_appbar_circle.dart';

import '../../../../core/colors/color.dart';

class EmployeeaddScreen extends StatefulWidget {
  const EmployeeaddScreen({super.key});

  @override
  State<EmployeeaddScreen> createState() => _EmployeeaddScreenState();
}

class _EmployeeaddScreenState extends State<EmployeeaddScreen> {
  String selectedGroup = 'Hội bán vải HCM';
  String selectedRole = 'Quản lý tài chính';
  String selectedAppointee = 'Ung Sang';
  String selectedAuthority = 'Tất cả các quyền hạn';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: cusAppBarCircle(context, title: "Thêm Nhân Viên"),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    _buildSectionTitle(context, "Nhóm"),
                    _buildDropdownButton(
                      value: selectedGroup,
                      items: [
                        'Hội bán vải HCM',
                        'Hội bán vải HN',
                        'Hội bán vải DN'
                      ],
                      onChanged: (value) =>
                          setState(() => selectedGroup = value!),
                    ),
                    _buildSectionTitle(context, "Vai trò"),
                    _buildDropdownButton(
                      value: selectedRole,
                      items: [
                        'Nhân viên bán hàng',
                        'Quản lý kho',
                        'Quản lý tài chính'
                      ],
                      onChanged: (value) =>
                          setState(() => selectedRole = value!),
                    ),
                    _buildSectionTitle(context, "Người được bổ nhiệm"),
                    _buildDropdownButton(
                      value: selectedAppointee,
                      items: ['Ung Sang', 'Sang Ung', 'Cabby'],
                      onChanged: (value) =>
                          setState(() => selectedAppointee = value!),
                    ),
                    _buildSectionTitle(context, "Quyền hạn"),
                    _buildDropdownButton(
                      value: selectedAuthority,
                      items: ['Tất cả các quyền hạn'],
                      onChanged: (value) =>
                          setState(() => selectedAuthority = value!),
                    ),
                    const SizedBox(height: 30),
                    _buildActionButtons(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: context.theme.textTheme.headlineSmall
          ?.copyWith(fontWeight: FontWeight.w600),
    );
  }

  Widget _buildDropdownButton({
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(0, 4),
            blurRadius: 4,
          ),
        ],
      ),
      child: DropdownButtonFormField<String>(
        decoration: const InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Styles.colorF9F9F9,
        ),
        dropdownColor: Styles.colorF9F9F9,
        value: value,
        isExpanded: true,
        items: items
            .map((item) => DropdownMenuItem(
                  value: item,
                  child: Text(item),
                ))
            .toList(),
        onChanged: onChanged,
        icon: const Icon(Icons.arrow_drop_down),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildGradientButton(
          text: 'Thêm Nhân Viên',
          colors: [
            const Color(0xFF218FF2),
            const Color(0xFF13538C),
          ],
          onPressed: () async {
            await showDialog(
              context: context,
              builder: (BuildContext context) {
                return const CardAddedSuccessDialog();
              },
            );
            Navigator.pop(context);
            Navigator.pop(context);
          },
        ),
      ],
    );
  }

  Widget _buildGradientButton({
    required String text,
    required List<Color> colors,
    required VoidCallback onPressed,
  }) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: colors,
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            elevation: 0,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
