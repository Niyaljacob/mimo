import 'package:flutter/material.dart';

class CategoryDetailPage extends StatelessWidget {
  final String title;

  CategoryDetailPage({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: ListView(
          children: [
            // Today Section
            SectionHeader(title: "Today"),
            TaskItem(
              title: "10 min Running",
              isCompleted: true,
            ),
            TaskItem(
              title: "5 min Rope Skipping",
              isCompleted: true,
            ),

            // Yesterday Section
            SectionHeader(title: "Yesterday"),
            TaskItem(title: "10 Push ups"),
            TaskItem(title: "10 Pull ups"),
            TaskItem(title: "20 Squads"),
            TaskItem(title: "30 Jumps"),

            // Past Section
            SectionHeader(title: "Fri, Oct 04, 2019"),
            TaskItem(title: "Lose 20 Kg"),
            TaskItem(title: "Reach 50 Push ups"),
            TaskItem(title: "Reach 15 min Rope Skipping"),
            TaskItem(title: "Reach 100 Squads"),

            SectionHeader(title: "Wed, Jan 01, 2020"),
            TaskItem(title: "Lose 10 Kg"),
            TaskItem(title: "Reach 100 Push ups"),
            TaskItem(title: "Reach 20 min Rope Skipping"),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddTaskDialog(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddTaskDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        final screenHeight = MediaQuery.of(context).size.height; // Get the screen height
        final dialogTopPosition = screenHeight * 0.25; // 25% of the screen height

        return Stack(
          children: [
            Positioned(
              top: dialogTopPosition, // Position the dialog at 25% of the screen height
              left: 16, // Optional: You can also set a margin for the dialog
              right: 16,
              child: Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: SingleChildScrollView( // Allow the dialog to scroll if necessary
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
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
                    Navigator.of(context).pop(); // Close the dialog
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

// Section Header Widget
class SectionHeader extends StatelessWidget {
  final String title;

  const SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.grey,
        ),
      ),
    );
  }
}

// Task Item Widget
class TaskItem extends StatelessWidget {
  final String title;
  final bool isCompleted;

  const TaskItem({
    required this.title,
    this.isCompleted = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
        color: isCompleted ? Colors.green : Colors.grey,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          color: isCompleted ? Colors.black : Colors.black87,
        ),
      ),
    );
  }
}
