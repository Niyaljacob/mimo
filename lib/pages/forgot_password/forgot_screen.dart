import 'package:flutter/material.dart';
import 'package:mimo/controllers/getX/forgot_password_getx.dart';

import 'package:mimo/pages/login/widgets/elevated_button.dart';
import 'package:mimo/pages/login/widgets/register_text.dart';
import 'package:mimo/pages/login/widgets/textform.dart';
import 'package:mimo/pages/sigup/sigup_screen.dart';
import 'package:mimo/utils/validations.dart';
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
          child: Column(
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
                  return _buildPopupDialog(context, controller);
                }
                return Container(); // No popup shown
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPopupDialog(BuildContext context, ForgotPasswordController controller) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 16,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            controller.message.value == 'Sending email...'
                ? const CircularProgressIndicator()  // Show loading spinner
                : Text(
                    controller.message.value,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16),
                  ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                controller.closePopup();
              },
              child: const Text('Close'),
            ),
          ],
        ),
      ),
    );
  }
}

// class ForgotPasswordController extends GetxController {
//   var showPopup = false.obs;
//   var message = ''.obs;

//   Future<void> resetPassword(String email) async {
//     try {
//       message.value = 'Sending email...';  // Show "Sending email..." message
//       showPopup.value = true;
//       await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
//       message.value = 'Check your email to reset the password.';
//       Future.delayed(Duration(seconds: 3), () {
//         closePopup();
//       });
//     } catch (e) {
//       message.value = 'Error: ${e.toString()}';
//       showPopup.value = true;
//     }
//   }

//   void closePopup() {
//     showPopup.value = false;
//   }
// }
