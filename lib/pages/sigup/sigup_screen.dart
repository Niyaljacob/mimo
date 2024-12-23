import 'package:flutter/material.dart';
import 'package:mimo/pages/login/login_screen.dart';
import 'package:mimo/pages/login/widgets/elevated_button.dart';
import 'package:mimo/pages/login/widgets/textform.dart';
import 'package:mimo/pages/sigup/widget/login_text_button.dart';

class SigupScreen extends StatelessWidget {
  const SigupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create an Account'),),
      body: Padding(
        padding: const EdgeInsets.all(35.0),
        child: Column(
          children: [
            SizedBox(height: 50,),
            CustomTextFormField(
              label: 'Full Name'),
              SizedBox(height: 25,),
              CustomTextFormField(
              label: 'Email'),
              SizedBox(height: 25,),
              CustomTextFormField(
              label: 'Password'),
              SizedBox(height: 25,),
              CustomTextFormField(
              label: 'Confirm Password'),
              SizedBox(height: 45,),
              CustomElevatedButton(text: 'CONTINUE', onPressed: (){}),
              LoginText(onRegisterPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (_){
                  return LoginScreen();
                }));
              },)
          ],
        ),
      ),
    );
    
  }
}