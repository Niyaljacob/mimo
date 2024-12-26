import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  var emoji = '😎✨'.obs; // Default emoji
  var title = ''.obs; // Default title
  var taskCount = 0.obs; // Default task count

  // Observable list to store categories
  var categories = [].obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategories(); // Fetch categories when the controller is initialized
  }

  // Function to add/update category in Firestore
  Future<void> updateCategory(String newEmoji, String newTitle) async {
    try {
      String userId = _auth.currentUser!.uid;

      // Create or update the category document
      await _firestore.collection('users').doc(userId).collection('categories').add({
        'emoji': newEmoji,
        'title': newTitle,
        'taskCount': taskCount.value,
        'createdAt': DateTime.now(),
      });

      // Update local state
      emoji.value = newEmoji;
      title.value = newTitle;

      // Fetch updated categories
      fetchCategories();

      Get.snackbar('Success', 'Category updated successfully');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  // Function to fetch categories from Firestore
  Future<void> fetchCategories() async {
    try {
      String userId = _auth.currentUser!.uid;

      final snapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('categories')
          .orderBy('createdAt', descending: true)
          .get();

      // Map Firestore documents to a list of categories
      categories.value = snapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

   // Function to delete a category from Firestore
  Future<void> deleteCategory(String categoryId) async {
    try {
      String userId = _auth.currentUser!.uid;

      // Delete the category document by its ID
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('categories')
          .doc(categoryId)
          .delete();

      // Fetch updated categories after deletion
      fetchCategories();

      Get.snackbar('Success', 'Category deleted successfully');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }
}
