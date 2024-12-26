import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:mimo/controllers/getX/task_controller.dart';

/// Groups tasks by their creation date.
Map<DateTime, List<Map<String, dynamic>>> groupTasksByDate(
    List<Map<String, dynamic>> tasks) {
  Map<DateTime, List<Map<String, dynamic>>> groupedTasks = {};
  for (var task in tasks) {
    final createdAt = (task['createdAt'] as Timestamp).toDate();
    final taskDate = DateTime(createdAt.year, createdAt.month, createdAt.day);
    if (!groupedTasks.containsKey(taskDate)) {
      groupedTasks[taskDate] = [];
    }
    groupedTasks[taskDate]!.add(task);
  }
  return groupedTasks;
}

/// Displays a dialog for adding a new task.
void showAddTaskDialog(BuildContext context, TaskController taskController) {
  final TextEditingController textController = TextEditingController();

  showDialog(
    context: context,
    builder: (context) {
      final screenHeight = MediaQuery.of(context).size.height;
      final dialogTopPosition = screenHeight * 0.25;

      return Stack(
        children: [
          Positioned(
            top: dialogTopPosition,
            left: 16,
            right: 16,
            child: Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(0.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: textController,
                        decoration: const InputDecoration(
                          hintText: 'Type your task…',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            right: 40,
            top: 225,
            child: Container(
              height: 20,
              width: 30,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.black, size: 15),
                padding: EdgeInsets.zero,
                onPressed: () {
                  if (textController.text.trim().isNotEmpty) {
                    taskController.addTask(textController.text.trim());
                    Navigator.pop(context);
                  } else {
                    Get.snackbar('Error', 'Task title cannot be empty');
                  }
                },
              ),
            ),
          ),
        ],
      );
    },
  );
}
