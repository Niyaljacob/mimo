import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileController extends GetxController {
  // Observables for user profile data
  var userName = ''.obs;
  var userEmail = ''.obs;
  var userProfileImage = 'assets/profile.jpg'.obs; // Default image
  var userLocation = ''.obs;
  var userAboutMe = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _getUserData();  // Fetch user data when the controller is initialized
  }

  // Method to fetch user data from Firestore
  void _getUserData() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      try {
        // Fetch user document from Firestore using UID
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        if (userDoc.exists) {
          userName.value = userDoc['fullName'] ?? 'No Name';
          userEmail.value = userDoc['email'] ?? 'No Email';
          userProfileImage.value = userDoc['profileImage'] ?? 'assets/profile.jpg';
          userLocation.value = userDoc['location'] ?? '';  // Fetch location
          userAboutMe.value = userDoc['aboutMe'] ?? '';  // Fetch aboutMe
        }
      } catch (e) {
        print('Error fetching user data: $e');
      }
    }
  }

  // Method to update user profile data in Firestore
  Future<void> updateUserProfile(String fullName, String location, String aboutMe) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      try {
        await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
          'fullName': fullName,
          'location': location,
          'aboutMe': aboutMe,
        });

        // Update local observable values
        userName.value = fullName;
        userLocation.value = location;  // Update location in local state
        userAboutMe.value = aboutMe;  // Update aboutMe in local state

        // Optionally, you can call _getUserData() to make sure the data is updated after changing it
        _getUserData();
      } catch (e) {
        print('Error updating user profile: $e');
      }
    }
  }
}
