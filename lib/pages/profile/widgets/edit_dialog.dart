import 'package:flutter/material.dart';
import 'package:mimo/controllers/getX/profile_getx.dart';

class EditDialog {
  static void show(BuildContext context, ProfileController controller) {
    final TextEditingController nameController =
        TextEditingController(text: controller.fullName.value);
    final TextEditingController locationController =
        TextEditingController(text: controller.location.value);
    final TextEditingController aboutController =
        TextEditingController(text: controller.aboutMe.value);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Profile'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: locationController,
                decoration: const InputDecoration(labelText: 'Location'),
              ),
              TextField(
                controller: aboutController,
                decoration: const InputDecoration(labelText: 'About Me'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                controller.updateUserData(
                  nameController.text,
                  locationController.text,
                  aboutController.text,
                );
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
