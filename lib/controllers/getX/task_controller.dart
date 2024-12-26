import 'package:get/get.dart';
import 'package:mimo/controllers/firebse/task_adding.dart';

class TaskController extends GetxController {
  final FirebaseService _firebaseService = FirebaseService();

  var tasks = <Map<String, dynamic>>[].obs;

  late String categoryId;

  void setCategoryId(String id) {
    categoryId = id;
    fetchTasks();
  }

  Future<void> addTask(String taskTitle) async {
    try {
      await _firebaseService.addTask(categoryId, taskTitle);
      fetchTasks();
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  Future<void> toggleTaskCompletion(String taskId, bool isCompleted) async {
    try {
      await _firebaseService.updateTaskCompletion(categoryId, taskId, isCompleted);
      fetchTasks();
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  Future<void> fetchTasks() async {
    try {
      tasks.value = await _firebaseService.getTasks(categoryId);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }
}
