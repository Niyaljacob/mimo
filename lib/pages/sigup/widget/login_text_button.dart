import 'package:flutter/material.dart';
import 'package:mimo/utils/constance.dart';

class LoginText extends StatelessWidget {
  final VoidCallback onRegisterPressed;

  const LoginText({super.key, required this.onRegisterPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
         Text(
          "Alredy have aan account? ",
          style: TextStyle(fontSize: 16, color: Theme.of(context).brightness == Brightness.light
                    ? black
                    : whiteColor,), // Optional text style
        ),
        TextButton(
          onPressed: onRegisterPressed,
          child:  Text(
            "Login",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color:Theme.of(context).brightness == Brightness.light
                    ? black
                    : whiteColor,),
          ),
        ),
      ],
    );
  }
}
