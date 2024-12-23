import 'package:flutter/material.dart';
import 'dart:async';
import 'package:mimo/pages/login/login_screen.dart';
import 'package:mimo/pages/home/home_screen.dart'; // Import HomeScreen for logged-in users
import 'package:firebase_auth/firebase_auth.dart'; // Import FirebaseAuth
import 'package:mimo/pages/splash_screen/widgets/splash_image.dart'; // Import for handling timers

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

    // Navigate based on the login status
    Timer(const Duration(seconds: 3), () {
      if (user != null) {
        // User is logged in, navigate to HomeScreen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      } else {
        // User is not logged in, navigate to LoginScreen
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
