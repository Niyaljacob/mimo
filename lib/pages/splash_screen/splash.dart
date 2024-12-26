import 'package:flutter/material.dart';
import 'dart:async';
import 'package:mimo/pages/login/login_screen.dart';
import 'package:mimo/pages/home/home_screen.dart'; 
import 'package:firebase_auth/firebase_auth.dart'; 
import 'package:mimo/pages/splash_screen/widgets/splash_image.dart'; 

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    // Check if the user is logged in
    User? user = FirebaseAuth.instance.currentUser;

    Timer(const Duration(seconds: 3), () {
      if (user != null) {
 
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      } else {
 
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SplashImage(),
    );
  }
}
