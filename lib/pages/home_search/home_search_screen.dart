import 'package:flutter/material.dart';
import 'package:mimo/pages/caterory_details_page/category_details_screen.dart';
import 'package:mimo/utils/constance.dart';

class CategorySearchDelegate extends SearchDelegate {
  final List categories;
  final Function(String) onSearch;

  CategorySearchDelegate({required this.categories, required this.onSearch});

  @override
  String? get searchFieldLabel => 'Search Categories';

  @override
  TextInputAction get textInputAction => TextInputAction.done;

  @override
  Widget buildResults(BuildContext context) {
    return _buildCategoryGrid();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildCategoryGrid();
  }

  Widget _buildCategoryGrid() {
    final filteredCategories = categories
        .where((category) => (category['title'] ?? '').toLowerCase().contains(query.toLowerCase()))
        .toList();

    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
         crossAxisCount: 2,
                          crossAxisSpacing: 15.0,
                          mainAxisSpacing: 15.0,
                          childAspectRatio: 3 / 2,
      ),
      itemCount: filteredCategories.length,
      itemBuilder: (context, index) {
        final category = filteredCategories[index];
        return GestureDetector(
            onTap: () {
    // Navigate to the new page with category title and id
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CategoryDetailPage(
          title: category['title'] ?? 'Default Title',
        ),
      ),
    );
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
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(category['emoji'] ?? '😎✨'),
                      Text(
                        category['title'] ?? 'Default Title',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                          color: Theme.of(context).brightness == Brightness.light
                              ? black
                              : whiteColor,
                        ),
                      ),
                      Text(
                        '${category['taskCount'] ?? 0} tasks',
                        style: TextStyle(
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
                    child: Icon(Icons.more_vert),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Implement buildActions
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  // Implement buildLeading
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }
}
