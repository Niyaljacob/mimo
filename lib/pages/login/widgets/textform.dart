import 'package:flutter/material.dart';
import 'package:mimo/utils/constance.dart';

class CustomTextFormField extends StatelessWidget {
  final String label;
  final String? Function(String?)? validator;

  const CustomTextFormField({super.key, required this.label, this.validator});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4, // Shadow effect
      shadowColor: Colors.grey.withOpacity(0.3), // Shadow color with opacity
      borderRadius: BorderRadius.circular(5), // Match the border radius
      child: TextFormField(
        validator: validator,
        decoration: InputDecoration(
          labelText: label,
          labelStyle:  TextStyle(color:  Theme.of(context).brightness == Brightness.light
                    ? secondPrimary
                    : whiteColor,),
          filled: true,
          fillColor:  Theme.of(context).brightness == Brightness.light
                    ? whiteColor
                    : secondPrimary,
          contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          // No borders, but with small corner radius
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5), // Small curve
            borderSide: BorderSide.none, // No border
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5), // Small curve
            borderSide: BorderSide.none, // No border
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5), // Small curve
            borderSide: BorderSide.none, // No border
          ),
        ),
      ),
    );
  }
}
