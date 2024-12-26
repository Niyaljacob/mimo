import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:mimo/controllers/getX/category_controller.getx.dart';
import 'package:mimo/pages/caterory_details_page/category_details_screen.dart';
import 'package:mimo/pages/home/widgets/adding_container.dart';
import 'package:mimo/pages/home/widgets/categories_container.dart';
import 'package:mimo/pages/home/widgets/home_screen_first_container.dart';
import 'package:mimo/pages/home/widgets/show_dialoge.dart';

class HomeScreenUi extends StatelessWidget {
  const HomeScreenUi({
    super.key,
    required this.categoryController,
    required String searchQuery,
  }) : _searchQuery = searchQuery;

  final CategoryController categoryController;
  final String _searchQuery;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const HomeScreenFirstContainer(),
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
                        child: const AddingContainer(),
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
                      child: CategorieContainer(category: category),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

