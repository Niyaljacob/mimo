import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> addTask(String categoryId, String taskTitle) async {
    String userId = _auth.currentUser!.uid;
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('categories')
        .doc(categoryId)
        .collection('tasks')
        .add({
      'title': taskTitle,
      'isCompleted': false,
      'createdAt': DateTime.now(),
    });
  }

  Future<void> updateTaskCompletion(String categoryId, String taskId, bool isCompleted) async {
    String userId = _auth.currentUser!.uid;
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('categories')
        .doc(categoryId)
        .collection('tasks')
        .doc(taskId)
        .update({'isCompleted': isCompleted});
  }

  Future<List<Map<String, dynamic>>> getTasks(String categoryId) async {
    String userId = _auth.currentUser!.uid;
    final snapshot = await _firestore
        .collection('users')
        .doc(userId)
        .collection('categories')
        .doc(categoryId)
        .collection('tasks')
        .orderBy('createdAt', descending: true)
        .get();

    return snapshot.docs
        .map((doc) => {'id': doc.id, ...doc.data() as Map<String, dynamic>})
        .toList();
  }
}
