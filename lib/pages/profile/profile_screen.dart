import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mimo/controllers/firebse/firebase_auth.dart';
import 'package:mimo/controllers/getX/profile_getx.dart';
import 'package:mimo/utils/constance.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final ProfileController _controller = Get.put(ProfileController());
  final FirebaseAuthService _authService = FirebaseAuthService(); // Instance of FirebaseAuthService

  void _showLogoutDialog(BuildContext context) {
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
                await _authService.signOutUser(); // Sign out using _authService
                Get.offAllNamed('/login'); // Navigate to the login screen using GetX
              },
              child: const Text('Log Out'),
            ),
          ],
        );
      },
    );
  }

  void _showEditDialog(BuildContext context) {
    final TextEditingController nameController =
        TextEditingController(text: _controller.fullName.value);
    final TextEditingController locationController =
        TextEditingController(text: _controller.location.value);
    final TextEditingController aboutController =
        TextEditingController(text: _controller.aboutMe.value);

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
                _controller.updateUserData(
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Settings',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile section
            ListTile(
              leading: const CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage('assets/profile.jpg'),
              ),
              title: Text(
                _controller.fullName.value.isNotEmpty
                    ? _controller.fullName.value
                    : 'Loading...',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                _controller.location.value.isNotEmpty
                    ? _controller.location.value
                    : 'Location not set',
                style: const TextStyle(fontSize: 12),
              ),
              trailing: GestureDetector(
                onTap: () => _showEditDialog(context),
                child: const CircleAvatar(
                  radius: 25,
                  backgroundColor: secondPrimary,
                  child: Icon(
                    Icons.edit,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
              child: Text(
                _controller.aboutMe.value.isNotEmpty
                    ? _controller.aboutMe.value
                    : 'This is a placeholder for the About Me section.',
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ),
            const SizedBox(height: 50),
            // Additional options
            ListTile(
              leading: const Icon(Icons.notifications, color: Colors.grey),
              title: const Text('Notifications'),
              onTap: () {
                // Add navigation or functionality
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings, color: Colors.grey),
              title: const Text('Settings'),
              onTap: () {
                // Add navigation or functionality
              },
            ),
            ListTile(
              leading: const Icon(Icons.account_circle, color: Colors.grey),
              title: const Text('Account'),
              onTap: () {
                // Add navigation or functionality
              },
            ),
            ListTile(
              leading: const Icon(Icons.info, color: Colors.grey),
              title: const Text('About'),
              onTap: () {
                // Add navigation or functionality
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text(
                'Log Out',
              ),
              onTap: () {
                _showLogoutDialog(context); // Call logout dialog
              },
            ),
          ],
        ),
      ),
    );
  }
}
