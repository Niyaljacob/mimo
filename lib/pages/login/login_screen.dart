import 'package:flutter/material.dart';
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
    return Scaffold(
      body: Center(
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
              CustomTextFormField(label: 'Email', validator: validateEmail),
              const SizedBox(height: 20),
              CustomTextFormField(label: 'Password', validator: validatePassword),
              const SizedBox(height: 5),
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  onPressed: () {
                    
                  },
                  child:  Text(
                    'Forgot Password?',
                    style: TextStyle(color:Theme.of(context).brightness == Brightness.light
                    ? black
                    : whiteColor,),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              CustomElevatedButton(text: 'CONTINUE', onPressed: (){}),
              RegisterText(onRegisterPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (_){
                  return SigupScreen();
                }));
              },)
            ],
          ),
        ),
      ),
    );
  }
}
