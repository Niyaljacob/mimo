import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:mimo/controllers/getX/forgot_password_getx.dart';
import 'package:mimo/pages/forgot_password/widgets/popupdialogue.dart';
import 'package:mimo/pages/login/widgets/elevated_button.dart';
import 'package:mimo/pages/login/widgets/register_text.dart';
import 'package:mimo/pages/login/widgets/textform.dart';
import 'package:mimo/pages/sigup/sigup_screen.dart';
import 'package:mimo/utils/validations.dart';

class ForgotPasswordUi extends StatelessWidget {
  const ForgotPasswordUi({
    super.key,
    required this.emailController,
    required this.controller,
  });

  final TextEditingController emailController;
  final ForgotPasswordController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 50),
        CustomTextFormField(
          controller: emailController,
          validator: validateEmail,
          label: "Email",
        ),
        const SizedBox(height: 15),
        const Center(
          child: Text(
            'Enter the email address you used to create your account and we will email you a link to reset your password.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12),
          ),
        ),
        const SizedBox(height: 40),
        CustomElevatedButton(
          text: 'CONTINUE',
          onPressed: () {
            String email = emailController.text;
            controller.resetPassword(email);
          },
        ),
        const SizedBox(height: 40),
        RegisterText(
          onRegisterPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (_) => SigupScreen(),
              ),
            );
          },
        ),
        Obx(() {
          if (controller.showPopup.value) {
            return PopupDialog(controller: controller);
          }
          return Container(); // No popup shown
        }),
      ],
    );
  }
}