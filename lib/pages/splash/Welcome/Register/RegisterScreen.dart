import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_youtex/core/size/size.dart';
import 'package:ui_youtex/core/themes/theme_extensions.dart';
import 'package:ui_youtex/util/constants.dart';
import 'package:ui_youtex/util/show_snack_bar.dart';

import '../../../../bloc/register/register_bloc.dart';
import '../../../../bloc/register/register_state.dart';
import '../../../../core/assets.dart';
import '../../../../core/colors/color.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isCheckPolicy = false;
  bool isVisibility = true;
  bool isComVisibility = true;
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  TextEditingController name = TextEditingController();

  String nameValidator = "null";
  String emailValidator = "null";
  String passwordValidator = "null";

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => NetworkConstants.hideKeyBoard,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16, top: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Title Đăng ký
                const Text(
                  "Đăng ký",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF005B99),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                const Text(
                  "Tạo tài khoản mới",
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),

                Container(
                  decoration: const BoxDecoration(boxShadow: [
                    BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0, 2),
                        blurRadius: 3)
                  ]),
                  child: TextField(
                    controller: phoneNumber,
                    decoration: InputDecoration(
                      hintStyle: const TextStyle(color: Color(0xFFB5B2B2)),
                      prefixIcon: const Icon(
                        Icons.person,
                        color: Styles.color005B99,
                      ),
                      hintText: "Số điện thoại",
                      filled: true,
                      fillColor: const Color(0xFFEEFBFF),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                textField(name, Icons.person_outline_rounded, "Name"),
                nameValidator != "null"
                    ? Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            nameValidator,
                            style: const TextStyle(
                                color: Colors.red, fontSize: 12),
                          ),
                        ),
                      )
                    : const SizedBox(
                        height: 15,
                      ),
                textField(email, Icons.email, "Email"),
                emailValidator != "null"
                    ? Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            emailValidator,
                            style: const TextStyle(
                                color: Colors.red, fontSize: 12),
                          ),
                        ),
                      )
                    : const SizedBox(
                        height: 15,
                      ),
                textField(password, Icons.punch_clock, "Mật khẩu",
                    iconRight: Icons.visibility_off,
                    isVisibility: isVisibility, onVisibilityChanged: () {
                  setState(() {
                    isVisibility = !isVisibility;
                  });
                }),
                passwordValidator != "null"
                    ? Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            passwordValidator,
                            style: const TextStyle(
                                color: Colors.red, fontSize: 12),
                          ),
                        ),
                      )
                    : const SizedBox(
                        height: 15,
                      ),
                textField(
                    confirmPassword, Icons.punch_clock, "Nhập lại mật khẩu",
                    iconRight: Icons.visibility_off,
                    isVisibility: isComVisibility, onVisibilityChanged: () {
                  setState(() {
                    isComVisibility = !isComVisibility;
                  });
                }),
                const SizedBox(height: 15),

                Row(
                  children: [
                    Checkbox(
                        activeColor: const Color(0xFF00B2F6),
                        value: isCheckPolicy,
                        onChanged: (value) {
                          setState(() {
                            isCheckPolicy = value!;
                          });
                        }),
                    const Text("Đồng ý với điều khoản sử dụng"),
                  ],
                ),
                const SizedBox(height: 20),
                BlocListener<RegisterBloc, RegisterState>(
                  listener: (context, state) {
                    if (state is RegisterLoading) {
                      const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is RegisterSuccess) {
                      SnackBarUtils.showSuccessSnackBar(context,
                          message: state.message);

                      Navigator.pushNamedAndRemoveUntil(
                          context, '/login', (route) => false);
                    } else if (state is RegisterFailure) {
                      SnackBarUtils.showWarningSnackBar(context,
                          message: "Có lỗi xảy ra");
                      setState(() {
                        nameValidator = "${state.nameError}";
                        emailValidator = "${state.emailError}";
                        passwordValidator = "${state.passwordError}";
                      });
                    }
                  },
                  child: InkWell(
                    onTap: () {
                      context.read<RegisterBloc>().add(
                            SubmitRegister(
                              name: name.text,
                              phone: phoneNumber.text,
                              email: email.text,
                              password: password.text,
                              passwordConfirmation: confirmPassword.text,
                            ),
                          );
                    },
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      height: MediaQuery.sizeOf(context).height / 14,
                      decoration: BoxDecoration(
                        color: isCheckPolicy ? Styles.nearPrimary : Styles.grey,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Text(
                        'Đăng Ký',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      height: 1,
                      width: context.width * 0.2,
                      color: Colors.black,
                    ),
                    Text(
                      "Hoặc tiếp tục với",
                      style: context.theme.textTheme.headlineSmall,
                    ),
                    Container(
                      height: 1,
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      width: context.width * 0.2,
                      color: Colors.black,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.facebook,
                        color: Colors.blue,
                        size: 55,
                      ),
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: Image.asset(
                          Asset.iconGg1,
                          height: 45,
                        )),
                    IconButton(
                      onPressed: () {
                        Navigator.pushNamed(
                            context,
                            '/memberVip'
                            '');
                      },
                      icon: const Icon(
                        Icons.apple,
                        color: Colors.black,
                        size: 55,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Điều hướng đến màn hình Đăng nhập
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Bạn đã có tài khoản? "),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/login');
                      },
                      child: const Text(
                        "Đăng nhập",
                        style: TextStyle(color: Color(0xFF00B2F6)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // TextFormField(
  // Widget textField(
  //   TextEditingController? controller,
  //   IconData icon,
  //   String hintText, {
  //   IconData? iconRight,
  //   bool? isVisibility,
  // }) {
  //   return Container(
  //     decoration: const BoxDecoration(boxShadow: [
  //       BoxShadow(color: Colors.black26, offset: Offset(0, 2), blurRadius: 3)
  //     ]),
  //     child: TextField(
  //       controller: controller,
  //       obscureText: isVisibility ?? false,
  //       decoration: InputDecoration(
  //         hintStyle: const TextStyle(color: Color(0xFFB5B2B2)),
  //         prefixIcon: Icon(
  //           icon,
  //           color: Styles.color005B99,
  //         ),
  //         suffixIcon: iconRight != null && isVisibility == true
  //             ? GestureDetector(
  //                 onTap: () {
  //                   setState(() {
  //                     isVisibility = !isVisibility!;
  //                   });
  //                 },
  //                 child: Icon(
  //                   isVisibility ?? false
  //                       ? Icons.visibility_off_outlined
  //                       : Icons.visibility_outlined,
  //                   color: Styles.color005B99,
  //                 ),
  //               )
  //             : null,
  //         hintText: hintText,
  //         filled: true,
  //         fillColor: const Color(0xFFEEFBFF),
  //         border: OutlineInputBorder(
  //             borderRadius: BorderRadius.circular(8),
  //             borderSide: BorderSide.none),
  //       ),
  //     ),
  //   );
  // }
  Widget textField(
    TextEditingController? controller,
    IconData icon,
    String hintText, {
    IconData? iconRight,
    bool? isVisibility = false,
    Function? onVisibilityChanged,
  }) {
    return Container(
      decoration: const BoxDecoration(boxShadow: [
        BoxShadow(color: Colors.black26, offset: Offset(0, 2), blurRadius: 3)
      ]),
      child: TextField(
        controller: controller,
        obscureText: isVisibility ?? false,
        decoration: InputDecoration(
          hintStyle: const TextStyle(color: Color(0xFFB5B2B2)),
          prefixIcon: Icon(
            icon,
            color: Styles.color005B99,
          ),
          suffixIcon: iconRight != null
              ? GestureDetector(
                  onTap: () {
                    if (onVisibilityChanged != null) {
                      onVisibilityChanged(); // Gọi hàm callback khi nhấn vào icon
                    }
                  },
                  child: Icon(
                    isVisibility ?? false
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: Styles.color005B99,
                  ),
                )
              : null,
          hintText: hintText,
          filled: true,
          fillColor: const Color(0xFFEEFBFF),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none),
        ),
      ),
    );
  }
}
