import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mimo/controllers/getX/task_controller.dart';
import 'package:intl/intl.dart';
import 'package:mimo/pages/caterory_details_page/widgets/task_helpers.dart';
import 'package:mimo/pages/caterory_details_page/widgets/task_items.dart';
import 'package:mimo/pages/task_search/task_serach_screen.dart';
import 'package:mimo/utils/constance.dart';

class CategoryDetailPage extends StatelessWidget {
  final String title;
  final String categoryId;

  CategoryDetailPage({super.key, required this.title, required this.categoryId});

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
          final tasksGroupedByDate = groupTasksByDate(taskController.tasks); 
          return ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            children: tasksGroupedByDate.entries.map((entry) {
              final date = entry.key;
              final tasks = entry.value;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      date == DateTime.now()
                          ? 'Today'
                          : date == DateTime.now().add(const Duration(days: 1))
                              ? 'Tomorrow'
                              : DateFormat('EEE, MMM dd, yyyy').format(date),
                      style: const TextStyle(
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
                  }),
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
          onPressed: () => showAddTaskDialog(context, taskController), 
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

  
}

