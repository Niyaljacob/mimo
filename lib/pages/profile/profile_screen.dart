import 'package:flutter/material.dart';
import 'package:mimo/controllers/firebse/firebase_auth.dart';
import 'package:mimo/controllers/getX/profile_getx.dart';
import 'package:mimo/pages/login/login_screen.dart';
import 'package:mimo/pages/profile/widgets/show_dialog.dart';
import 'package:mimo/utils/constance.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Instantiate ProfileController and use GetX to manage state
    final ProfileController controller = Get.put(ProfileController());

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Settings',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuthService().signOutUser();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
          ),
        ],
      ),
      body: Obx(() {
        return Column(
          children: [
            ListTile(
              leading: CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage(controller.userProfileImage.value),
              ),
              title: Text(
                controller.userName.value,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                controller.userLocation.value.isNotEmpty
                    ? controller.userLocation.value
                    : 'No Location',
                style: const TextStyle(fontSize: 12),
              ),
              trailing: GestureDetector(
                onTap: () {
                  // Show edit dialog when clicked
                  _showEditDialog(context, controller);
                },
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: secondPrimary,
                  child: const Icon(
                    Icons.edit,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              ),
            ),
            // Show the "About Me" section below the ListTile
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(
                controller.userAboutMe.value.isNotEmpty
                    ? controller.userAboutMe.value
                    : 'No information available.',
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ),
          ],
        );
      }),
    );
  }

  // Function to show the edit dialog
  void _showEditDialog(BuildContext context, ProfileController controller) {
    showDialog(
      context: context,
      builder: (context) {
        return ProfileEditDialog(controller: controller);  // Use the dialog from another file
      },
    );
  }
}
