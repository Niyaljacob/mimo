import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mimo/controllers/getX/auth_getx.dart';
import 'package:mimo/model/user_model.dart';
import 'package:mimo/pages/login/login_screen.dart';
import 'package:mimo/pages/login/widgets/elevated_button.dart';
import 'package:mimo/pages/login/widgets/textform.dart';
import 'package:mimo/utils/validations.dart';

class SigupScreen extends StatelessWidget {
  SigupScreen({super.key});

  final RegisterController _registerController = Get.put(RegisterController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Create an Account'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(35.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 40),
                CustomTextFormField(
                  validator: validateUsername,
                  controller: _fullNameController,
                  label: 'Full Name',
                ),
                const SizedBox(height: 25),
                CustomTextFormField(
                  validator: validateEmail,
                  controller: _emailController,
                  label: 'Email',
                ),
                const SizedBox(height: 25),
                CustomTextFormField(
                  validator: validatePassword,
                  controller: _passwordController,
                  label: 'Password',
                  isPassword: true,
                ),
                const SizedBox(height: 25),
                CustomTextFormField(
                  validator: (value) {
                    if (value != _passwordController.text) {
                      return "Passwords do not match";
                    }
                    return null;
                  },
                  controller: _confirmPasswordController,
                  label: 'Confirm Password',
                  isPassword: true,
                ),
                const SizedBox(height: 45),
                Obx(() {
                  return _registerController.isLoading.value
                      ? const CircularProgressIndicator()
                      : CustomElevatedButton(
                          text: 'CONTINUE',
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              final registerModel = RegisterModel(
                                fullName: _fullNameController.text.trim(),
                                email: _emailController.text.trim(),
                                password: _passwordController.text,
                              );
                              _registerController.registerUser(registerModel);
                            }
                          },
                        );
                }),
                TextButton(
                  onPressed: () => Get.off(() => const LoginScreen()),
                  child: const Text('Already have an account? Login'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
