import 'package:flutter/material.dart';
import 'package:mimo/pages/login/widgets/textform.dart';
import 'package:mimo/utils/validations.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        
        child: Padding(
          padding: const EdgeInsets.all(35.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/splash_white.png'),
                  CustomTextFormField(label: 'Email', validator: validateEmail),
                  const SizedBox(height: 20),
                  CustomTextFormField(label: 'Password', validator: validatePassword),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Form validation logic can be added here.
                    },
                    child: const Text('Submit'),
                  ),
                ],
              ),
        ),
      ),
    );
  }
}