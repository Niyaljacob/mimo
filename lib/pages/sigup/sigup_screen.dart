import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mimo/controllers/getX/auth_getx.dart';
import 'package:mimo/pages/sigup/widget/signup_screen_ui.dart';


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
            child: SignUpScreenUi(fullNameController: _fullNameController, emailController: _emailController, passwordController: _passwordController, confirmPasswordController: _confirmPasswordController, registerController: _registerController, formKey: _formKey),
          ),
        ),
      ),
    );
  }
}

