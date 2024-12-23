import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? buttonColor;
  final Color? textColor;

  const CustomElevatedButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.buttonColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity, // Full width
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5), // Circular radius of 5
          ),
          backgroundColor:const Color.fromARGB(255, 5, 60, 105), // Default to primary color
          padding: const EdgeInsets.symmetric(vertical: 15), // Adjust button size
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            color: textColor ?? Colors.white, // Default to white text color
            fontSize: 16, // Customize font size
            fontWeight: FontWeight.w600, // Slightly bold
          ),
        ),
      ),
    );
  }
}
