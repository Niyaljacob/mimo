import 'package:flutter/material.dart';
import 'package:mimo/controllers/getX/forgot_password_getx.dart';
import 'package:mimo/pages/forgot_password/widgets/forgot_password_ui.dart';
import 'package:get/get.dart';

class ForgotScreen extends StatelessWidget {
  const ForgotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ForgotPasswordController controller = Get.put(ForgotPasswordController());
    final TextEditingController emailController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Forgot Password'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(35.0),
          child: ForgotPasswordUi(emailController: emailController, controller: controller),
        ),
      ),
    );
  }

}

