import 'package:flutter/material.dart';
import 'package:mimo/controllers/firebse/firebase_auth.dart';
import 'package:mimo/pages/login/login_screen.dart';
import 'package:mimo/pages/profile/profile_screen.dart'; // Import your Profile screen

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            // Navigate to profile page when the image is tapped
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProfileScreen()),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 20,  
              height: 20, 
              decoration: BoxDecoration(
                shape: BoxShape.circle, 
                image: DecorationImage(
                  image: AssetImage('assets/profile.jpg'),
                  fit: BoxFit.cover,  
                ),
              ),
            ),
          ),
        ),
        centerTitle: true,
        title: const Text("Categories",style: TextStyle(fontWeight: FontWeight.bold),),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
           
              await FirebaseAuthService().signOutUser();
              
              
              Navigator.pushReplacement(
                // ignore: use_build_context_synchronously
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: const Text('Welcome to Home Screen!'),
      ),
    );
  }
}
