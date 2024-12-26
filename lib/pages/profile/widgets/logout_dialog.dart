import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mimo/controllers/firebse/firebase_auth.dart';

class LogoutDialog {
  static void show(BuildContext context) {
    final FirebaseAuthService authService = FirebaseAuthService();

    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text('Log Out'),
          content: const Text('Are you sure you want to log out?'),
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            CupertinoDialogAction(
              isDestructiveAction: true,
              onPressed: () async {
                Navigator.of(context).pop(); // Close the dialog
                await authService.signOutUser(); // Sign out
                Get.offAllNamed('/login'); // Navigate to the login screen
              },
              child: const Text('Log Out'),
            ),
          ],
        );
      },
    );
  }
}
