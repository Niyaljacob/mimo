import 'package:flutter/material.dart';
import 'package:mimo/controllers/getX/forgot_password_getx.dart';

class PopupDialog extends StatelessWidget {
  final ForgotPasswordController controller;

  const PopupDialog({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 16,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            controller.message.value == 'Sending email...'
                ? const CircularProgressIndicator()
                : Text(
                    controller.message.value,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16),
                  ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                controller.closePopup();
              },
              child: const Text('Close'),
            ),
          ],
        ),
      ),
    );
  }
}
