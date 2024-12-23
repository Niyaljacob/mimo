import 'package:flutter/material.dart';
import 'package:mimo/utils/constance.dart';

class CustomTextFormField extends StatelessWidget {
  final String label;
  final String? Function(String?)? validator;

  const CustomTextFormField({super.key, required this.label, this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: grey),
        filled: true,
        fillColor: secondPrimary,
        contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        // No borders, but with small corner radius
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10), // Small curve
          borderSide: BorderSide.none, // No border
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10), // Small curve
          borderSide: BorderSide.none, // No border
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10), // Small curve
          borderSide: BorderSide.none, // No border
        ),
      ),
    );
  }
}
