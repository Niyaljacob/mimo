import 'package:flutter/material.dart';
import 'package:mimo/utils/constance.dart';

class LoginScreenImage extends StatelessWidget {
  const LoginScreenImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        Theme.of(context).brightness == Brightness.light
            ? whiteSplash
            : blackSplash,
      ),
    );
  }
}
