import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mimo/utils/constance.dart';

class HomeScreenFirstContainer extends StatelessWidget {
  const HomeScreenFirstContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
            backgroundImage: AssetImage(profileImage),
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
                    color: grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
