// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class FirebaseAuthService {
//   // Example method to update user profile in Firestore
//   Future<void> updateUserProfile(String newName, String newLocation, String newAboutMe) async {
//     try {
//       // Assuming Firestore collection 'users' where user profile data is stored
//       final user = FirebaseAuth.instance.currentUser;
//       if (user != null) {
//         await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
//           'name': newName,
//           'location': newLocation,
//           'aboutMe': newAboutMe,
//         });
//       }
//     } catch (e) {
//       print("Error updating profile: $e");
//       throw e;
//     }
//   }
// }
