
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mimo/controllers/getX/auth_getx.dart';
import 'package:mimo/model/user_model.dart';
import 'package:mimo/pages/login/login_screen.dart';
import 'package:mimo/pages/login/widgets/elevated_button.dart';
import 'package:mimo/pages/login/widgets/textform.dart';
import 'package:mimo/utils/constance.dart';
import 'package:mimo/utils/validations.dart';

class SignUpScreenUi extends StatelessWidget {
  const SignUpScreenUi({
    super.key,
    required TextEditingController fullNameController,
    required TextEditingController emailController,
    required TextEditingController passwordController,
    required TextEditingController confirmPasswordController,
    required RegisterController registerController,
    required GlobalKey<FormState> formKey,
  }) : _fullNameController = fullNameController, _emailController = emailController, _passwordController = passwordController, _confirmPasswordController = confirmPasswordController, _registerController = registerController, _formKey = formKey;

  final TextEditingController _fullNameController;
  final TextEditingController _emailController;
  final TextEditingController _passwordController;
  final TextEditingController _confirmPasswordController;
  final RegisterController _registerController;
  final GlobalKey<FormState> _formKey;

  @override
  Widget build(BuildContext context) {
    return Column(
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
          child:  Text('Already have an account? Login',style: TextStyle(color: Theme.of(context).brightness == Brightness.light
            ? black
            : whiteColor,),),
        ),
      ],
    );
  }
}
