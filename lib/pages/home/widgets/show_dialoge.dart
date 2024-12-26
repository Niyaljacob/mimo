import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mimo/controllers/getX/category_controller.getx.dart';
import 'package:mimo/utils/constance.dart';

Future<void> showMyDialog(BuildContext context, CategoryController controller) async {
  TextEditingController titleController = TextEditingController();
  TextEditingController emojiController = TextEditingController(text: controller.emoji.value);

  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    barrierColor: Colors.black.withOpacity(0.5),
    builder: (BuildContext context) {
      return Stack(
        children: [
          Positioned(
            top: 100, // Adjusted position
            left: 20,
            right: 20,
            child: Container(
              width: 600,
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    backgroundColor: secondPrimary, // Same background color
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            // Show a dialog to edit emoji
                            String? newEmoji = await showDialog<String>(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Enter Emoji or Text'),
                                  content: TextField(
                                    controller: emojiController, // Bind to emoji controller
                                    decoration: const InputDecoration(
                                      hintText: "Type your emoji or text here",
                                    ),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      child: const Text('OK'),
                                      onPressed: () {
                                        Navigator.of(context).pop(emojiController.text);
                                      },
                                    ),
                                  ],
                                );
                              },
                            );

                            if (newEmoji != null && newEmoji.isNotEmpty) {
                              controller.emoji.value = newEmoji; // Update the emoji
                            }
                          },
                          child: Obx(() => Text(
                                controller.emoji.value, // Display updated emoji
                                style: const TextStyle(fontSize: 24, color: Colors.white),
                              )),
                        ),
                      ],
                    ),
                    content: SingleChildScrollView(
                      child: ListBody(
                        children: [
                          const Text(
                            'Title',
                            style: TextStyle(
                              color: Color.fromARGB(255, 128, 128, 128),
                              fontSize: 30,
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            controller: titleController,
                            decoration: const InputDecoration(
                              hintText: "Enter Title",
                            ),
                            onChanged: (value) {
                              // Prevent save logic from triggering here
                              // No action needed
                            },
                          ),
                          const SizedBox(height: 20),
                          Obx(() => Text(
                                "Task Count: ${controller.taskCount.value}",
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 119, 117, 117),
                                  fontSize: 20,
                                ),
                              )),
                        ],
                      ),
                    ),
                  ),
                  // Close icon
                  Positioned(
                    right: 35,
                    top: 18,
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.close, color: Colors.blue, size: 15),
                        onPressed: () {
                          Navigator.of(context).pop(); // Close the dialog
                        },
                      ),
                    ),
                  ),
                  // Save (check) icon
                  Positioned(
                    top: 175,
                    left: 0,
                    right: -280,
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.check, color: Colors.blue, size: 15),
                        onPressed: () {
                          // Save updated emoji and title to Firebase
                          if (titleController.text.trim().isNotEmpty) {
                            controller.updateCategory(
                              emojiController.text, // Pass the updated emoji
                              titleController.text, // Pass the title
                            );
                            Navigator.of(context).pop(); // Save and close the dialog
                          } else {
                            // Show error message if the title is empty
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Title cannot be empty'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    },
  );
}
