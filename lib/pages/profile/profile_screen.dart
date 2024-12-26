import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mimo/controllers/getX/profile_getx.dart';
import 'package:mimo/pages/profile/widgets/edit_dialog.dart';
import 'package:mimo/pages/profile/widgets/logout_dialog.dart';
import 'package:mimo/utils/constance.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final ProfileController _controller = Get.put(ProfileController());

  

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
                backgroundImage: AssetImage(profileImage2),
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
                onTap: () => EditDialog.show(context, _controller),
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
            const ListTile(
              leading: Icon(Icons.notifications, color: Colors.grey),
              title: Text('Notifications'),
            ),
            const ListTile(
              leading: Icon(Icons.settings, color: Colors.grey),
              title: Text('Settings'),
            ),
            const ListTile(
              leading: Icon(Icons.account_circle, color: Colors.grey),
              title: Text('Account'),
            ),
            const ListTile(
              leading: Icon(Icons.info, color: Colors.grey),
              title: Text('About'),
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text(
                'Log Out',
              ),
              onTap: () {
                LogoutDialog.show(context); // Call logout dialog
              },
            ),
          ],
        ),
      ),
    );
  }
}
