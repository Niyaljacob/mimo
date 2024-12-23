import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mimo/pages/home/home_screen.dart'; 

class LoginController extends GetxController {
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  // Firebase Authentication instance
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> loginUser(String email, String password) async {
    try {
      isLoading.value = true;
      errorMessage.value = ''; // Clear any previous errors

      // Firebase authentication logic
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Check if the login is successful
      if (userCredential.user != null) {
        Get.snackbar(
          "Login Successful",
          "Welcome back!",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );
        // Navigate to the home screen after login
        Get.offAll(() => const HomeScreen()); // Change HomeScreen to your target screen
      }
    } catch (e) {
      // Handle errors and show error message
      errorMessage.value = e.toString();
      Get.snackbar(
        "Login Failed",
        errorMessage.value,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
    } finally {
      isLoading.value = false;
    }
  }
}
