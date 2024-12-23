import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgotPasswordController extends GetxController {
  // Observable to control the visibility of the popup
  var showPopup = false.obs;
  var message = ''.obs;

  // Function to handle the "Continue" button press
  Future<void> resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      message.value = 'Check your email to reset the password.';
      showPopup.value = true;
    } catch (e) {
      message.value = 'Error: ${e.toString()}';
      showPopup.value = true;
    }
  }

  // Function to close the popup
  void closePopup() {
    showPopup.value = false;
  }
}
