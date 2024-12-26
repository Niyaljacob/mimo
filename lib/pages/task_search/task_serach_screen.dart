import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:intl/intl.dart';
import 'package:mimo/controllers/getX/task_controller.dart';
import 'package:mimo/pages/caterory_details_page/widgets/task_items.dart';

class SearchPage extends StatelessWidget {
  final TaskController taskController;

  SearchPage({super.key, required this.taskController});

  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Search Tasks',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: searchController,
              decoration: const InputDecoration(
                labelText: 'Enter date (yyyy-MM-dd)',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                taskController.tasks.refresh(); // Refresh tasks to apply search
              },
            ),
          ),
          Expanded(
            child: Obx(
              () {
                final queryDate = _parseDate(searchController.text);
                final filteredTasks = taskController.tasks.where((task) {
                  final createdAt = (task['createdAt'] as Timestamp).toDate();
                  return queryDate != null &&
                      DateTime(
                            createdAt.year,
                            createdAt.month,
                            createdAt.day,
                          ) ==
                          queryDate;
                }).toList();

                return ListView.builder(
                  itemCount: filteredTasks.length,
                  itemBuilder: (context, index) {
                    final task = filteredTasks[index];
                    return TaskItem(
                      taskId: task['id'],
                      title: task['title'],
                      isCompleted: task['isCompleted'],
                      onChanged: (value) {
                        taskController.toggleTaskCompletion(task['id'], value);
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  DateTime? _parseDate(String input) {
    try {
      return DateFormat('yyyy-MM-dd').parseStrict(input);
    } catch (e) {
      return null;
    }
  }
}
