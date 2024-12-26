import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mimo/controllers/getX/category_controller.getx.dart';
import 'package:mimo/pages/home/widgets/show_dialoge.dart';
import 'package:mimo/pages/profile/profile_screen.dart';
import 'package:mimo/utils/constance.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CategoryController categoryController = Get.put(CategoryController());

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfileScreen()),
            );
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Container(
              width: 20,
              height: 20,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage('assets/profile.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        centerTitle: true,
        title: const Text(
          "Categories",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: Theme.of(context).brightness == Brightness.light
                    ? whiteColor
                    : primary,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
           child:Column(
            children: [
               Container(
                height: 120,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.light
                    ? whiteColor
                    : secondPrimary,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child:  Row(
        
        children: [
          // Circular avatar for profile image
          CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage('assets/profile.jpg'),
          ),
          SizedBox(width: 16), // Spacing between avatar and text
          // Title and subtitle
          Padding(
            padding: EdgeInsets.only(top: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '"The memmories is a sheild and life helper"', // Title text
                  style: TextStyle(
                    
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).brightness == Brightness.light
                    ? black
                    : whiteColor,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Tamim AI-Barghouti', // Subtitle text
                  style: TextStyle(
                    fontSize: 8,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),


      Expanded(
        child: Obx(
              () {
                // Combine the "add container" with the existing categories.
                final categories = [
                  {"isAddContainer": true}, // Add this container as the first element.
                  ...categoryController.categories,
                ];
        
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 15.0,
                      mainAxisSpacing: 15.0,
                      childAspectRatio: 3 / 2,
                    ),
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      if (categories[index]["isAddContainer"] == true) {
                        // This is the "add container"
                        return GestureDetector(
                          onTap: () {
                            showMyDialog(context, categoryController);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).brightness == Brightness.light
                    ? whiteColor
                    : secondPrimary,
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color.fromARGB(255, 134, 122, 122).withOpacity(0.1),
                                  spreadRadius: 2,
                                  blurRadius: 2,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child:  Center(
                              child: CircleAvatar(
                                radius: 20.0,
                                backgroundColor: Theme.of(context).brightness == Brightness.light
                    ? secondPrimary
                    : whiteColor,
                                child: Icon(
                                  Icons.add,
                                  color: Theme.of(context).brightness == Brightness.light
                    ? whiteColor
                    : Colors.blue,
                                ),
                              ),
                            ),
                          ),
                        );
                      }
                          
                      // Normal category container
                      final category = categories[index];
                      return Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).brightness == Brightness.light
                    ? whiteColor
                    : secondPrimary,
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(
                              color: const Color.fromARGB(255, 134, 122, 122).withOpacity(0.1),
                              spreadRadius: 2,
                              blurRadius: 2,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Stack(
                          children: [
                            Padding(
                              padding:  EdgeInsets.fromLTRB(20, 20, 0, 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(category['emoji'] ?? '😎✨'),
                                  Text(
                                    category['title'] ?? 'Default Title',
                                    style:  TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20,
                                      color: Theme.of(context).brightness == Brightness.light
                    ? black
                    : whiteColor,
                                    ),
                                  ),
                                  Text(
                                    '${category['taskCount'] ?? 0} tasks',
                                    style:  TextStyle(
                                      fontSize: 16,
                                      color: Theme.of(context).brightness == Brightness.light
                    ? black
                    : whiteColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Positioned(
                              bottom: 0,
                              right: 0,
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.more_vert,
                                  color: grey,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
            ),
      ),
            ],
           )
        ),
      ),
    );
  }
}


 