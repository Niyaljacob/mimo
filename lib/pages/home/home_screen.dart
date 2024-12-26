import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mimo/controllers/getX/category_controller.getx.dart';

import 'package:mimo/pages/home/widgets/home_screen_ui.dart';

import 'package:mimo/pages/home_search/home_search_screen.dart';
import 'package:mimo/pages/profile/profile_screen.dart';
import 'package:mimo/utils/constance.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CategoryController categoryController = Get.put(CategoryController());
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
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
                  image: AssetImage(profileImage2),
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
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: CategorySearchDelegate(
                  categories: categoryController.categories,
                  onSearch: (query) {
                    setState(() {
                      _searchQuery = query;
                    });
                  },
                ),
              );
            },
          ),
        ],
      ),
      backgroundColor: Theme.of(context).brightness == Brightness.light
          ? whiteColor
          : primary,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: HomeScreenUi(categoryController: categoryController, searchQuery: _searchQuery),
        ),
      ),
    );
  }
}

