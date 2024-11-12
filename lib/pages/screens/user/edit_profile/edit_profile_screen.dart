import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ui_youtex/core/colors/color.dart';
import 'package:ui_youtex/core/size/size.dart';
import 'package:ui_youtex/core/themes/theme_extensions.dart';
import 'package:ui_youtex/model/user_profile.dart';
import 'package:ui_youtex/pages/widget_small/text_form_field.dart';

import '../../../../bloc/edit_profile_bloc/edit_profile_bloc.dart';
import '../../../../bloc/user_profile_bloc/user_profile_bloc.dart';
import '../../../../util/constants.dart';
import '../../../../util/show_snack_bar.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _birthdayController = TextEditingController();
  String? _selectedImagePath;
  String _selectedGender = 'male';

  var nameError = "null";
  var genderError = "null";
  var birthdayError = "null";

  final ImagePicker _picker = ImagePicker();

  void _selectImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _selectedImagePath = image.path;
      });
    } else {
      SnackBarUtils.showWarningSnackBar(context, message: "No image selected");
    }
  }

  Widget _buildGenderSelectionRadio() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Gender',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        RadioListTile<String>(
          title: const Text('Male'),
          value: 'male',
          groupValue: _selectedGender,
          onChanged: (value) {
            setState(() {
              _selectedGender = value!;
            });
          },
        ),
        RadioListTile<String>(
          title: const Text('Female'),
          value: 'female',
          groupValue: _selectedGender,
          onChanged: (value) {
            setState(() {
              _selectedGender = value!;
            });
          },
        ),
        RadioListTile<String>(
          title: const Text('Other'),
          value: 'other',
          groupValue: _selectedGender,
          onChanged: (value) {
            setState(() {
              _selectedGender = value!;
            });
          },
        ),
      ],
    );
  }

  Widget _validate({required String error}) {
    return error != "null"
        ? Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                error,
                style: const TextStyle(color: Colors.red, fontSize: 12),
              ),
            ),
          )
        : const SizedBox(
            height: 15,
          );
  }

  void _updateProfile() {
    context.read<EditProfileBloc>().add(UpdateProfile(
          name: _nameController.text,
          gender: _selectedGender,
          birthday: _birthdayController.text,
          imagePath: "$_selectedImagePath",
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Styles.blue,
          centerTitle: true,
          leading: InkWell(
              onTap: () => Navigator.pop(context),
              child: const Icon(
                Icons.arrow_back_ios,
                color: Styles.light,
              )),
          title: Text(
            'Chỉnh sửa tài khoản',
            style: context.theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold, color: Styles.light, fontSize: 17),
          ),
        ),
        body: BlocBuilder<UserProfileBloc, UserProfileState>(
            builder: (context, state) {
          if (state is UserProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is UserProfileError) {
            return Text(state.message);
          } else if (state is UserProfileLoaded) {
            final user = state.user;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Profile Header
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Styles.colorF3F3F3,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          blurRadius: 4,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: NetworkImage(
                              "${NetworkConstants.urlImage}${user.image}"), // Replace with your profile image
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                user.name,
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(width: 20),
                              SizedBox(
                                  width: context.width * 0.28,
                                  child: Text(
                                    '@${NetworkConstants.convertToUnaccentedNoSpace(user.name)}\t\t',
                                    style: const TextStyle(
                                        overflow: TextOverflow.ellipsis),
                                  )),
                              const SizedBox(width: 20),
                              Text('Ngày sinh: ${user.birthday}'),
                              const SizedBox(width: 20),
                              Text('Giới tính: ${user.gender}'),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => EditProfile(
                                          user: user,
                                        ),
                                      ));
                                },
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      color: Styles.color3D6190,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Text(
                                      "Chỉnh sửa",
                                      style: TextStyle(
                                          color: Styles.light, fontSize: 12),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildSettingItem(
                    "Số điện thoại",
                    "********${user.phone.substring(user.phone.length - 3, user.phone.length)}",
                    () {},
                  ),
                  _buildSettingItem(
                    "Địa chỉ email",
                    "********${user.email.substring(user.email.length - 13, user.email.length)}",
                    () {},
                  ),
                  _buildSettingItem(
                    "Đổi mật khẩu",
                    "",
                    () {},
                  ),
                ],
              ),
            );
          }
          return const Center(
            child: Text("Có lỗi xảy ra"),
          );
        }));
  }
}

Widget _buildSettingItem(String title, String content, VoidCallback onTap) {
  return Container(
    margin: const EdgeInsets.only(bottom: 8, top: 4),
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
      title: Text(
        title,
        style: const TextStyle(fontSize: 16),
      ),
      subtitle: content.isNotEmpty
          ? Text(content, style: const TextStyle(fontSize: 14))
          : null,
      trailing: const Icon(Icons.chevron_right, color: Colors.grey),
      onTap: onTap,
    ),
  );
}

class EditProfile extends StatefulWidget {
  final Profile user;

  const EditProfile({super.key, required this.user});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _birthdayController = TextEditingController();
  String? _selectedImagePath;
  String _selectedGender = 'male';

  var nameError = "null";
  var genderError = "null";
  var birthdayError = "null";

  final ImagePicker _picker = ImagePicker();

  void _selectImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _selectedImagePath = image.path;
      });
    } else {
      SnackBarUtils.showWarningSnackBar(context, message: "No image selected");
    }
  }

  Widget _buildGenderSelectionRadio() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Gender',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        RadioListTile<String>(
          title: const Text('Male'),
          value: 'male',
          groupValue: _selectedGender,
          onChanged: (value) {
            setState(() {
              _selectedGender = value!;
            });
          },
        ),
        RadioListTile<String>(
          title: const Text('Female'),
          value: 'female',
          groupValue: _selectedGender,
          onChanged: (value) {
            setState(() {
              _selectedGender = value!;
            });
          },
        ),
        RadioListTile<String>(
          title: const Text('Other'),
          value: 'other',
          groupValue: _selectedGender,
          onChanged: (value) {
            setState(() {
              _selectedGender = value!;
            });
          },
        ),
      ],
    );
  }

  Widget _validate({required String error}) {
    return error != "null"
        ? Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                error,
                style: const TextStyle(color: Colors.red, fontSize: 12),
              ),
            ),
          )
        : const SizedBox(
            height: 15,
          );
  }

  void _updateProfile() {
    context.read<EditProfileBloc>().add(UpdateProfile(
          name: _nameController.text,
          gender: _selectedGender,
          birthday: _birthdayController.text,
          imagePath: "$_selectedImagePath",
        ));
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      setState(() {
        _birthdayController.text = pickedDate.toString().split(' ')[0]; // Format as yyyy-MM-dd
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Styles.blue,
        centerTitle: true,
        leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: const Icon(
              Icons.arrow_back_ios,
              color: Styles.light,
            )),
        title: Text(
          'Chỉnh sửa tài khoản',
          style: context.theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold, color: Styles.light, fontSize: 17),
        ),
      ),
      body: BlocConsumer<EditProfileBloc, EditProfileState>(
        listener: (context, state) {
          if (state is EditProfileSuccess) {
            SnackBarUtils.showSuccessSnackBar(context, message: state.message);
            _nameController.clear();
            _birthdayController.clear();
            Navigator.pop(context);
            setState(() {
              nameError = "null";
              genderError = "null";
              birthdayError = "null";
            });
          } else if (state is EditProfileFailure) {
            setState(() {
              nameError = "${state.name}";
              genderError = "${state.gender}";
              birthdayError = "${state.birthday}";
            });
            SnackBarUtils.showWarningSnackBar(context,
                message: "Failed to update profile");
          }
        },
        builder: (context, state) {
          if (state is EditProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        _selectImage();
                      },
                      child: Container(
                        height: 100,
                        width: 100,
                        alignment: Alignment.bottomRight,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey.shade200,
                            image: DecorationImage(
                                image: widget.user.image?.isEmpty ?? true
                                    ? FileImage(
                                        File(_selectedImagePath ?? "No Image"))
                                    : NetworkImage(
                                            "${NetworkConstants.urlImage}${widget.user.image}")
                                        as ImageProvider)),
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: const BoxDecoration(
                              color: Colors.white, shape: BoxShape.circle,boxShadow: [
                                BoxShadow(offset: Offset(0, 2),blurRadius: 4)
                          ]),
                          child: const Icon(Icons.add_a_photo_outlined),
                        ),
                      ),
                    ),
                    // const SizedBox(
                    //   width: 10,
                    // ),
                    // ElevatedButton(
                    //   onPressed: _selectImage,
                    //   child: const Text("Select Image"),
                    // ),
                  ],
                ),
                CustomTextFieldNoIcon(
                    controller: _nameController,
                    hintText: 'Tên hiện tại:\t"${widget.user.name}"',
                    label: "Tên"),
                _validate(error: nameError),
                _buildGenderSelectionRadio(),
                _validate(error: genderError),
                GestureDetector(
                  onTap: () => _selectDate(context),
                  child: AbsorbPointer(
                    child: CustomTextFieldNoIcon(
                        controller: _birthdayController,
                        hintText: "Nhập ngày dạng yyyy-MM-dd",
                        label: "Ngày sinh",readOnly: true,),
                  ),
                ),
                _validate(error: birthdayError),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 12),
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () => _updateProfile(),
                  child: const Text(
                    'Thay đổi',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
