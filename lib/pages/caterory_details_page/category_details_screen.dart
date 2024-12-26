import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mimo/controllers/getX/task_controller.dart';
import 'package:intl/intl.dart';
import 'package:mimo/pages/task_search/task_serach_screen.dart';
import 'package:mimo/utils/constance.dart';

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
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Navigate to Search Page
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SearchPage(taskController: taskController),
                ),
              );
            },
          ),
        ],
      ),
      body: Obx(
        () {
          final tasksGroupedByDate = _groupTasksByDate(taskController.tasks);
          return ListView(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            children: tasksGroupedByDate.entries.map((entry) {
              final date = entry.key;
              final tasks = entry.value;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      date == DateTime.now()
                          ? 'Today'
                          : date == DateTime.now().add(const Duration(days: 1))
                              ? 'Tomorrow'
                              : DateFormat('EEE, MMM dd, yyyy').format(date),
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ...tasks.map((task) {
                    return TaskItem(
                      taskId: task['id'],
                      title: task['title'],
                      isCompleted: task['isCompleted'],
                      onChanged: (value) {
                        taskController.toggleTaskCompletion(task['id'], value);
                      },
                    );
                  }).toList(),
                ],
              );
            }).toList(),
          );
        },
      ),
      floatingActionButton: Container(
        height: 60,
        width: 60,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).brightness == Brightness.light
              ? primary
              : whiteColor,
        ),
        child: FloatingActionButton(
          onPressed: () => _showAddTaskDialog(context),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child:  Icon(
            Icons.add,
            size: 35, 
            color:Theme.of(context).brightness ==
                                          Brightness.light
                                      ? whiteColor
                                      : Colors.blue, 
          ),
        ),
      ),
    );
  }

  Map<DateTime, List<Map<String, dynamic>>> _groupTasksByDate(
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

  void _showAddTaskDialog(BuildContext context) {
    final TextEditingController taskController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        final screenHeight =
            MediaQuery.of(context).size.height; // Get the screen height
        final dialogTopPosition =
            screenHeight * 0.25; // 25% of the screen height

        return Stack(
          children: [
            Positioned(
              top:
                  dialogTopPosition, // Position the dialog at 25% of the screen height
              left: 16, // Optional: You can also set a margin for the dialog
              right: 16,
              child: Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: SingleChildScrollView(
                    // Allow the dialog to scroll if necessary
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          controller: taskController,
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
                    if (taskController.text.trim().isNotEmpty) {
                      this.taskController.addTask(taskController.text.trim());
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
      leading: Container(
        height: 24,
        width: 24,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: isCompleted ? Colors.green : Colors.grey,
            width: 2,
          ),
          color: isCompleted ? Colors.green : Colors.transparent,
        ),
        child: isCompleted
            ? const Icon(Icons.check, color: Colors.white, size: 16)
            : null,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          decoration: isCompleted ? TextDecoration.lineThrough : null,
          color: isCompleted
              ? Colors.grey
              : Theme.of(context).brightness == Brightness.light
                  ? black
                  : whiteColor,
        ),
      ),
      onTap: () {
        onChanged(!isCompleted);
      },
    );
  }
}
