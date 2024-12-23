import 'package:flutter/material.dart';
import 'dart:async';

import 'package:mimo/pages/home/home_screen.dart';
import 'package:mimo/pages/login/login_screen.dart';
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
    Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()), 
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SplashImage(),
    );
  }
}


