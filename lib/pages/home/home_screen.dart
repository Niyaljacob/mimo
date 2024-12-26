import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mimo/controllers/getX/category_controller.getx.dart';
import 'package:mimo/pages/caterory_details_page/category_details_screen.dart';
import 'package:mimo/pages/home/widgets/show_dialoge.dart';
import 'package:mimo/pages/home_search/home_search_screen.dart';
import 'package:mimo/pages/profile/profile_screen.dart';
import 'package:mimo/utils/constance.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
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
          child: Column(
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
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage('assets/profile.jpg'),
                    ),
                    const SizedBox(width: 16),
                    Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '"The memories are a shield and life helper"',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? black
                                  : whiteColor,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Tamim AI-Barghouti',
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
                    final categories = [
                      {"isAddContainer": true},
                      ...categoryController.categories,
                    ];

                    // Filter categories based on the search query
                    final filteredCategories = categories.where((category) {
                      if (_searchQuery.isEmpty) return true;
                      return (category['title'] ?? '')
                          .toLowerCase()
                          .contains(_searchQuery.toLowerCase());
                    }).toList();

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 15.0,
                          mainAxisSpacing: 15.0,
                          childAspectRatio: 3 / 2,
                        ),
                        itemCount: filteredCategories.length,
                        itemBuilder: (context, index) {
                          if (filteredCategories[index]["isAddContainer"] ==
                              true) {
                            return GestureDetector(
                              onTap: () {
                                showMyDialog(context, categoryController);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Theme.of(context).brightness ==
                                          Brightness.light
                                      ? whiteColor
                                      : secondPrimary,
                                  borderRadius: BorderRadius.circular(5),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color.fromARGB(
                                              255, 134, 122, 122)
                                          .withOpacity(0.1),
                                      spreadRadius: 2,
                                      blurRadius: 2,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: CircleAvatar(
                                    radius: 20.0,
                                    backgroundColor:
                                        Theme.of(context).brightness ==
                                                Brightness.light
                                            ? secondPrimary
                                            : whiteColor,
                                    child: Icon(
                                      Icons.add,
                                      color: Theme.of(context).brightness ==
                                              Brightness.light
                                          ? whiteColor
                                          : Colors.blue,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }

                          final category = filteredCategories[index];
                          return GestureDetector(
                            onTap: () {
                              // Navigate to the new page with category title and id
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CategoryDetailPage(
                                    title: category['title'] ?? 'Default Title',
                                    categoryId: category['id'],
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).brightness ==
                                        Brightness.light
                                    ? whiteColor
                                    : secondPrimary,
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                        const Color.fromARGB(255, 134, 122, 122)
                                            .withOpacity(0.1),
                                    spreadRadius: 2,
                                    blurRadius: 2,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Stack(
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(20, 20, 0, 0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(category['emoji'] ?? '😎✨'),
                                        Text(
                                          category['title'] ?? 'Default Title',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 20,
                                            color:
                                                Theme.of(context).brightness ==
                                                        Brightness.light
                                                    ? black
                                                    : whiteColor,
                                          ),
                                        ),
                                        Text(
                                          '${category['taskCount'] ?? 0} tasks',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color:
                                                Theme.of(context).brightness ==
                                                        Brightness.light
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
                                      child: Icon(Icons.more_vert),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
