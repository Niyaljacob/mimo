import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mimo/controllers/getX/login_getx.dart';
import 'package:mimo/pages/forgot_password/forgot_screen.dart';
import 'package:mimo/pages/login/widgets/elevated_button.dart';
import 'package:mimo/pages/login/widgets/register_text.dart';
import 'package:mimo/pages/login/widgets/textform.dart';
import 'package:mimo/pages/sigup/sigup_screen.dart';
import 'package:mimo/utils/constance.dart';
import 'package:mimo/utils/validations.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Instantiate the LoginController
    final LoginController loginController = Get.put(LoginController());

    // Controllers for the TextFormFields
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(35.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start, // Aligns children to the left
              children: [
                const SizedBox(height: 150),
                Center(
                  child: Image.asset(
                    Theme.of(context).brightness == Brightness.light
                        ? whiteSplash
                        : blackSplash,
                  ),
                ),
                const SizedBox(height: 30),
                CustomTextFormField(
                  label: 'Email',
                  controller: emailController, // Controller added here
                  validator: validateEmail,
                  onChanged: (value) {
                    loginController.errorMessage.value = ''; // Clear any previous errors
                  },
                ),
                const SizedBox(height: 20),
                CustomTextFormField(
                  label: 'Password',
                  controller: passwordController, // Controller added here
                  validator: validatePassword,
                  onChanged: (value) {
                    loginController.errorMessage.value = ''; // Clear any previous errors
                  },
                  
                ),
                const SizedBox(height: 5),
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                        return ForgotScreen();
                      }));
                    },
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                        color: Theme.of(context).brightness == Brightness.light
                            ? black
                            : whiteColor,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Obx(() {
                  return loginController.isLoading.value
                      ? const Center(child: CircularProgressIndicator())
                      : CustomElevatedButton(
                          text: 'CONTINUE',
                          onPressed: () {
                            // Fetch the text from the controllers
                            String email = emailController.text.trim();
                            String password = passwordController.text.trim();
                            loginController.loginUser(email, password);
                          },
                        );
                }),
                RegisterText(
                  onRegisterPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                      return SigupScreen();
                    }));
                  },
                ),
                Obx(() {
                  // Display error message if login fails
                  if (loginController.errorMessage.value.isNotEmpty) {
                    return Text(
                      loginController.errorMessage.value,
                      style: const TextStyle(color: Colors.red),
                    );
                  }
                  return const SizedBox.shrink();
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
