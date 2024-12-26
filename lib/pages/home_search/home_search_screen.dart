import 'package:flutter/material.dart';
import 'package:mimo/pages/caterory_details_page/category_details_screen.dart';
import 'package:mimo/pages/home/widgets/categories_container.dart';

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
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
          categoryId: category['id'],
        ),
      ),
    );
  },
          child: CategorieContainer(category: category),
          
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
