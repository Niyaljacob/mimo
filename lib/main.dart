import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; // Import Firebase core package
import 'package:get/get.dart'; // Import GetX package
import 'package:mimo/pages/login/login_screen.dart';
import 'package:mimo/pages/splash_screen/splash.dart'; // Import your splash screen
import 'package:mimo/utils/theme.dart'; // Import your theme setup

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Ensure Firebase is initialized before running the app

  runApp(const MyApp()); // Run your app after Firebase initialization
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp( // Use GetMaterialApp for GetX support
      debugShowCheckedModeBanner: false,
      theme: Themes.lightModeTheme, // Light mode theme
      darkTheme: Themes.darkModeTheme, // Dark mode theme
      home: const SplashScreen(), // Set your initial screen here
      getPages: [
        // Define your routes here
        GetPage(name: '/', page: () => const SplashScreen()), // Splash screen
        GetPage(name: '/login', page: () => const LoginScreen()), // Login screen
        // Add other routes as needed
      ],
    );
  }
}
