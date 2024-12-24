import 'package:flutter/material.dart';
import 'package:mimo/pages/profile/profile_screen.dart'; // Import your Profile screen

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>  ProfileScreen()),
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
      ),
      body: Center(
        child: const Text('Welcome to Home Screen!'),
      ),
    );
  }
}
