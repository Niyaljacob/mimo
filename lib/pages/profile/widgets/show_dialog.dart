import 'package:flutter/material.dart';
import 'package:mimo/controllers/getX/profile_getx.dart';
import 'package:get/get.dart';

class ProfileEditDialog extends StatelessWidget {
  final ProfileController controller;

  ProfileEditDialog({required this.controller});

  @override
  Widget build(BuildContext context) {
    final TextEditingController usernameController = TextEditingController(text: controller.userName.value);
    final TextEditingController locationController = TextEditingController(text: controller.userLocation.value);
    final TextEditingController aboutMeController = TextEditingController(text: controller.userAboutMe.value);

    return AlertDialog(
      title: const Text('Edit Profile'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: usernameController,
            decoration: const InputDecoration(
              labelText: 'Username',
            ),
          ),
          TextField(
            controller: locationController,
            decoration: const InputDecoration(
              labelText: 'Location',
            ),
          ),
          TextField(
            controller: aboutMeController,
            decoration: const InputDecoration(
              labelText: 'About Me',
            ),
            maxLines: 3,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () async {
            // Update the values in Firebase
            await controller.updateUserProfile(
              usernameController.text,
              locationController.text,
              aboutMeController.text,
            );
            Get.back();  // Close the dialog
          },
          child: const Text('Save'),
        ),
        TextButton(
          onPressed: () {
            Get.back();  // Close the dialog
          },
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}
