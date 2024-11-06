import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_youtex/core/assets.dart';
import 'package:ui_youtex/core/colors/color.dart';
import 'package:ui_youtex/core/size/size.dart';
import 'package:ui_youtex/core/themes/theme_extensions.dart';
import 'package:ui_youtex/util/constants.dart';
import 'package:ui_youtex/util/show_snack_bar.dart';

import '../../../../bloc/login_bloc/login_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isVisibility = true;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  var emailError = "null";
  var passError = "null";
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: NetworkConstants.hideKeyBoard,
      child: Scaffold(
        body: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccess) {
              Navigator.pushNamed(
                  context,
                  '/CustomNavBar'
                  '');
            } else if (state is LoginFailure) {
              SnackBarUtils.showWarningSnackBar(context,
                  message: state.errorMessage);
              emailError = "${state.emailError}";
              passError = "${state.passwordError}";
            }
          },
          child: BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              return SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Image.asset(
                      'assets/images/Vector 1.png',
                      width: MediaQuery.sizeOf(context).width,
                      height: MediaQuery.sizeOf(context).height / 3.2,
                      fit: BoxFit.cover,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Form(
                        key: _formkey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Đăng nhập",
                              style: context.theme.textTheme.headlineLarge
                                  ?.copyWith(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Styles.nearPrimary,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "Đăng nhập bằng tài khoản của bạn",
                              style: context.theme.textTheme.headlineMedium
                                  ?.copyWith(
                                fontWeight: FontWeight.w400,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 30),

                            // Form Email và Mật khẩu
                            Container(
                              decoration: const BoxDecoration(boxShadow: [
                                BoxShadow(
                                    color: Colors.black26,
                                    offset: Offset(0, 2),
                                    blurRadius: 3)
                              ]),
                              child: TextFormField(
                                controller: emailController,
                                decoration: InputDecoration(
                                  hintStyle:
                                      const TextStyle(color: Color(0xFFB5B2B2)),
                                  prefixIcon: const Icon(
                                    Icons.email,
                                    color: Styles.color005B99,
                                  ),
                                  hintText: "Email",
                                  filled: true,
                                  fillColor: const Color(0xFFEEFBFF),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide.none),
                                ),
                              ),
                            ),
                            emailError != "null"?Padding(
                              padding: const EdgeInsets.symmetric(vertical:4.0),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(emailError,style: const TextStyle(
                                    color: Colors.red,
                                    fontSize: 12
                                ),),
                              ),
                            ):const SizedBox(height: 15,),
                            Container(
                              decoration: const BoxDecoration(boxShadow: [
                                BoxShadow(
                                    color: Colors.black26,
                                    offset: Offset(0, 2),
                                    blurRadius: 3)
                              ]),
                              child: TextFormField(
                                controller: passwordController,
                                obscureText: isVisibility,
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(
                                    // Icons.lock_clock_outlined,
                                    Icons.punch_clock,
                                    color: Styles.color005B99,
                                  ),
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isVisibility = !isVisibility;
                                      });
                                    },
                                     child: Icon(
                                      isVisibility
                                          ? Icons.visibility_off_outlined
                                          : Icons.visibility_outlined,
                                      color: Styles.color005B99,
                                    ),
                                  ),
                                  hintStyle:
                                      const TextStyle(color: Color(0xFFB5B2B2)),
                                  hintText: "Mật khẩu",
                                  filled: true,
                                  fillColor: const Color(0xFFEEFBFF),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide.none),
                                ),
                              ),
                            ),
                            const SizedBox(height: 4),
                            passError!="null"?
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(passError,style: const TextStyle(
                                  color: Colors.red,
                                  fontSize: 12
                                ),),
                              ),
                            ):Container(),
                            const SizedBox(height: 15),
                            // Checkbox ghi nhớ tài khoản
                            Row(
                              children: [
                                Checkbox(
                                    focusColor: const Color(0xFF00B2F6),
                                    activeColor: const Color(0xFF00B2F6),
                                    shape: const CircleBorder(),
                                    value: true,
                                    onChanged: (value) {}),
                                Text(
                                  "Ghi nhớ tài khoản",
                                  style: context.theme.textTheme.titleSmall
                                      ?.copyWith(),
                                ),
                                const Spacer(),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/Forgot');
                                  },
                                  child: Text(
                                    "Quên mật khẩu?",
                                    style: context.theme.textTheme.titleSmall
                                        ?.copyWith(
                                      color: Colors.blue,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),

                            // Nút Đăng nhập
                            if (state is LoginLoading) ...{
                              const Center(child: CircularProgressIndicator())
                            } else ...{
                              InkWell(
                                onTap: () {
                                  final email = emailController.text.trim();
                                  final password =
                                      passwordController.text.trim();
                                  if (_formkey.currentState!.validate()) {
                                    context.read<LoginBloc>().add(
                                          LoginButtonPressed(
                                              email: email, password: password),
                                        );
                                  }
                                },
                                child: Container(
                                  width: double.infinity,
                                  alignment: Alignment.center,
                                  height:
                                      MediaQuery.sizeOf(context).height / 14,
                                  decoration: BoxDecoration(
                                    color: Styles.nearPrimary,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: const Text(
                                    'Đăng Nhập',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            },
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text("Bạn chưa có tài khoản? "),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(context, '/register');
                                  },
                                  child: const Text(
                                    "Đăng ký",
                                    style: TextStyle(color: Color(0xFF00B2F6)),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10),
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
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10),
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
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
