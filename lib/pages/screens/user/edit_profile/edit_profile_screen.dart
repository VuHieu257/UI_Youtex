import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ui_youtex/pages/widget_small/text_form_field.dart';

import '../../../../bloc/edit_profile_bloc/edit_profile_bloc.dart';
import '../../../../util/show_snack_bar.dart';
class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
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
          style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
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
  Widget _validate({required String error}){
    return error != "null"?Padding(
      padding: const EdgeInsets.symmetric(vertical:4.0),
      child: Align(
        alignment: Alignment.topLeft,
        child: Text(error,style: const TextStyle(
            color: Colors.red,
            fontSize: 12
        ),),
      ),
    ):const SizedBox(height: 15,);
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
        backgroundColor: Colors.white,
        elevation: 2.0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
            // Handle back action
          },
        ),
        title: const Text(
          'Chỉnh sửa tài khoản',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<EditProfileBloc, EditProfileState>(
        listener: (context, state) {
          if (state is EditProfileSuccess) {
            SnackBarUtils.showSuccessSnackBar(context, message: state.message);
            _nameController.clear();
            _birthdayController.clear();
            Navigator.pop(context);
            setState(() {
              nameError="null";
              genderError="null";
              birthdayError="null";
            });
          } else if (state is EditProfileFailure) {
            setState(() {
              nameError="${state.name}";
              genderError="${state.gender}";
              birthdayError="${state.birthday}";
            });
            SnackBarUtils.showWarningSnackBar(context, message: "Failed to update profile");
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _selectedImagePath!=null
                        ?CircleAvatar(
                      radius: 50,
                      backgroundImage: FileImage(File(_selectedImagePath!)),
                    )
                    // Image.file(
                    //   ,
                    //   height: 100,
                    //   width: 100,
                    //   fit: BoxFit.cover,
                    // )
                        : Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          shape: BoxShape.circle
                      ),
                      child: const Center(child: Text("No Image")),
                    ),
                   const SizedBox(width: 10,),
                    ElevatedButton(
                      onPressed: _selectImage,
                      child: const Text("Select Image"),
                    ),
                  ],
                ),
                CustomTextFieldNoIcon(controller: _nameController,hintText: "Nhập tên bạn muốn thay đổi", label: "Tên"),
                _validate(error:nameError),
                _buildGenderSelectionRadio(),
                _validate(error:genderError),
                CustomTextFieldNoIcon(controller: _birthdayController,hintText: "Nhập ngày dạng yyyy-MM-dd", label: "Ngày sinh"),
                _validate(error:birthdayError),
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
