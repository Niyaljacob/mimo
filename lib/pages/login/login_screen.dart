import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mimo/controllers/getX/login_getx.dart';

import 'package:mimo/pages/login/widgets/login_screen_ui.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginController loginController = Get.put(LoginController());
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
      body: SingleChildScrollView(
        child: LoginScreenUi(emailController: emailController, loginController: loginController, passwordController: passwordController),
      ),
    );
  }
}

