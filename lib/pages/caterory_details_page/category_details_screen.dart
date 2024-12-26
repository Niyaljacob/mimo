import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mimo/controllers/getX/task_controller.dart';

class CategoryDetailPage extends StatelessWidget {
  final String title;
  final String categoryId;

  CategoryDetailPage({required this.title, required this.categoryId});

  final TaskController taskController = Get.put(TaskController());

  @override
  Widget build(BuildContext context) {
    taskController.setCategoryId(categoryId);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(title),
      ),
      body: Obx(
        () => ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          children: taskController.tasks.map((task) {
            return TaskItem(
              taskId: task['id'],
              title: task['title'],
              isCompleted: task['isCompleted'],
              onChanged: (value) {
                taskController.toggleTaskCompletion(task['id'], value);
              },
            );
          }).toList(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTaskDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddTaskDialog(BuildContext context) {
    final TextEditingController taskController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Task'),
          content: TextField(
            controller: taskController,
            decoration: const InputDecoration(hintText: 'Enter task title'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (taskController.text.trim().isNotEmpty) {
                  this.taskController.addTask(taskController.text.trim());
                  Navigator.pop(context);
                } else {
                  Get.snackbar('Error', 'Task title cannot be empty');
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }
}

class TaskItem extends StatelessWidget {
  final String taskId;
  final String title;
  final bool isCompleted;
  final ValueChanged<bool> onChanged;

  const TaskItem({
    required this.taskId,
    required this.title,
    required this.isCompleted,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        value: isCompleted,
        onChanged: (value) {
          onChanged(value ?? false);
        },
      ),
      title: Text(
        title,
      ),
    );
  }
}
