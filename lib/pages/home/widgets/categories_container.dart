import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mimo/utils/constance.dart';

class CategorieContainer extends StatelessWidget {
  const CategorieContainer({
    super.key,
    required this.category,
  });

  final  category;

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}

