import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mimo/utils/constance.dart';

class TaskItem extends StatelessWidget {
  final String taskId;
  final String title;
  final bool isCompleted;
  final ValueChanged<bool> onChanged;

  const TaskItem({super.key, 
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
