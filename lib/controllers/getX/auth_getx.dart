import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:mimo/controllers/firebse/firebase_auth.dart';
import 'package:mimo/model/user_model.dart';
import 'package:mimo/pages/login/login_screen.dart';

class RegisterController extends GetxController {
  final FirebaseAuthService _authService = FirebaseAuthService();
  var isLoading = false.obs; // To track the loading state

  // Registration function
  Future<void> registerUser(RegisterModel registerModel) async {
    try {
      isLoading.value = true; // Set loading state to true before initiating the registration process

      // Call the registration method
      await _authService.registerUser(registerModel);

      // Show success snackbar
      Get.snackbar(
        "Registration Successful",
        "Your account has been created.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
        margin: const EdgeInsets.all(10),
        borderRadius: 10,
      );

      // After success, navigate to the login screen with a delay to allow UI updates
      Future.delayed(const Duration(seconds: 1), () {
        Get.off(() => const LoginScreen());
      });
    } catch (e) {
      // Handle registration failure and display error message
      Get.snackbar(
        "Registration Failed",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
        margin: const EdgeInsets.all(10),
        borderRadius: 10,
      );
    } finally {
      // Ensure loading indicator is hidden after the process is complete
      isLoading.value = false;
    }
  }
}
