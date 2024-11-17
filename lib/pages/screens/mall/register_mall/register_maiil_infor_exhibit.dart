import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ui_youtex/bloc_seller/seller_register_tax_get_bloc/seller_register_tax_get_bloc_bloc.dart';
import 'package:ui_youtex/core/colors/color.dart';
import 'package:ui_youtex/core/themes/theme_extensions.dart';
import 'package:ui_youtex/pages/screens/home/add_success/add_success.dart';
import 'package:ui_youtex/pages/widget_small/appbar/custome_appbar_circle.dart';
import 'package:ui_youtex/services/restful_api_provider.dart';

class RegisterMallinforExhibitiScreen extends StatefulWidget {
  const RegisterMallinforExhibitiScreen({super.key});

  @override
  _RegisterMallinforExhibitiScreenState createState() =>
      _RegisterMallinforExhibitiScreenState();
}

class _RegisterMallinforExhibitiScreenState
    extends State<RegisterMallinforExhibitiScreen> {
  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;

  // Text controllers for the form fields
  final TextEditingController taxTypeController = TextEditingController();
  final TextEditingController taxNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController taxCodeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<SellerRegisterTaxBloc>().stream.listen((state) {
      if (state is SellerRegisterTaxLoaded) {
        _updateControllers(state.tax);
      }
    });
  }

  String selectedGroup = 'business';

  void _updateControllers(SellerRegisterTaxModel? tax) {
    if (tax != null) {
      setState(() {
        taxNameController.text = tax.name ?? '';
        addressController.text = tax.address ?? '';
        emailController.text = tax.email ?? '';
        taxCodeController.text = tax.taxCode ?? '';
      });
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SellerRegisterTaxBloc(
        restfulApiProvider: context.read<RestfulApiProviderImpl>(),
      )..add(SellerRegisterTaxGetBlocEvent()),
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              child: cusAppBarCircle(context, title: "Giấy Tờ"),
            ),
            Expanded(child: _buildBlocContent(context)),
          ],
        ),
      ),
    );
  }

  Widget _buildBlocContent(BuildContext context) {
    return BlocConsumer<SellerRegisterTaxBloc, SellerRegisterTaxBlocState>(
      listener: (context, state) {
        if (state is SellerRegisterTaxLoaded) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return CustomDialog(
                title: 'Thành Công',
                message: 'Tải dữ liệu giấy tờ thành công.',
              );
            },
          );
        }
      },
      builder: (context, state) {
        if (state is SellerRegisterTaxLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is SellerRegisterTaxLoaded) {
          return _buildForm(context, state.tax);
        }
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomDialog(
              title: 'Thông báo',
              message: 'Bạn chưa cập nhật giấy tờ.',
            );
          },
        );
        return _buildForm(context, null);
      },
    );
  }

  Widget _buildForm(BuildContext context, SellerRegisterTaxModel? tax) {
    final isReadOnly = tax != null;
    taxNameController.text = tax?.name ?? '';
    addressController.text = tax?.address ?? '';
    emailController.text = tax?.email ?? '';
    taxCodeController.text = tax?.taxCode ?? '';

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle(context, "Loại giấy tờ"),
            _buildDropdownButton(
              value: selectedGroup,
              items: ['business', 'personal'],
              onChanged: isReadOnly
                  ? null
                  : (value) => setState(() => selectedGroup = value!),
            ),
            CustomTextFieldNoIcon(
              label: "Tên công ty",
              hintText: "Điền thông tin tại đây",
              controller: taxNameController,
              line: 1,
              isReadOnly: isReadOnly,
            ),
            CustomTextFieldNoIcon(
              label: "Địa chỉ",
              hintText: "Điền thông tin tại đây",
              controller: addressController,
              line: 1,
              isReadOnly: isReadOnly,
            ),
            CustomTextFieldNoIcon(
              label: "Email",
              hintText: "Điền thông tin tại đây",
              controller: emailController,
              line: 1,
              isReadOnly: isReadOnly,
            ),
            CustomTextFieldNoIcon(
              label: "Tax Code",
              hintText: "Điền thông tin tại đây",
              controller: taxCodeController,
              line: 1,
              isReadOnly: isReadOnly,
            ),
            const SizedBox(height: 20),
            if (!isReadOnly) _buildImagePickerSection(context),
            const SizedBox(height: 30),
            if (!isReadOnly) _buildSaveButton(context),
          ],
        ),
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
    required ValueChanged<String?>? onChanged, // onChanged is nullable
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

  Widget _buildImagePickerSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Ảnh giấy phép kinh doanh',
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        _buildImageField('Ảnh', _selectedImage, _pickImage),
      ],
    );
  }

  Widget _buildImageField(String label, File? image, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 4),
              blurRadius: 4,
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(15),
                border: Border.all(width: 1),
              ),
              child: const Text(
                'Choose File',
                style: TextStyle(color: Colors.blue),
              ),
            ),
            Text(label),
            if (image != null) ...[
              const SizedBox(width: 10),
              Image.file(image, width: 50, height: 50),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildSaveButton(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF218FF2), Color(0xFF13538C)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(30),
            ),
            child: ElevatedButton(
              onPressed: () {
                final taxModel = SellerRegisterTaxModel(
                  type: selectedGroup,
                  address: addressController.text,
                  email: emailController.text,
                  taxCode: taxCodeController.text,
                  name: taxNameController.text,
                  businessLicense: _selectedImage?.path,
                );

                context
                    .read<SellerRegisterTaxBloc>()
                    .add(SellerRegisterTaxPostBlocEvent(model: taxModel));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                elevation: 0,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Text(
                  'Lưu thay đổi',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CustomTextFieldNoIcon extends StatelessWidget {
  final String label;
  final String hintText;
  final int? line;
  final TextEditingController controller;
  final bool isReadOnly;
  const CustomTextFieldNoIcon({
    super.key,
    required this.hintText,
    required this.label,
    required this.controller,
    this.line,
    required this.isReadOnly,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: const BorderRadius.all(Radius.circular(15)),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  offset: Offset(0, 4),
                  blurRadius: 4,
                ),
              ],
            ),
            child: TextField(
              readOnly: isReadOnly,
              controller: controller,
              maxLines: line ?? 1,
              decoration: InputDecoration(
                hintStyle: const TextStyle(color: Color(0xFFB5B2B2)),
                hintText: hintText,
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
