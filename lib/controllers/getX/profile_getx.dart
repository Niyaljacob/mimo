import 'package:get/get.dart';
import 'package:mimo/controllers/firebse/update_profile.dart';

class ProfileController extends GetxController {
  var fullName = ''.obs;
  var location = ''.obs;
  var aboutMe = ''.obs;

  final ProfileService _profileService = ProfileService();

  @override
  void onInit() {
    super.onInit();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    try {
      var userData = await _profileService.getUserData();
      if (userData != null) {
        fullName.value = userData['fullName'] ?? '';
        location.value = userData['location'] ?? '';
        aboutMe.value = userData['aboutMe'] ?? '';
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  Future<void> updateUserData(String name, String loc, String about) async {
    try {
      await _profileService.updateUserData(name, loc, about);
      fullName.value = name;
      location.value = loc;
      aboutMe.value = about;

      Get.snackbar('Success', 'Profile updated successfully!');
    } catch (e) {
      print('Error updating user data: $e');
      Get.snackbar('Error', 'Failed to update profile: $e');
    }
  }
}
