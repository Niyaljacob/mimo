import 'package:flutter/material.dart';
import 'package:mimo/utils/constance.dart';

class AddingContainer extends StatelessWidget {
  const AddingContainer({
    super.key,
  });

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
    );
  }
}

