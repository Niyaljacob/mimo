import 'package:flutter/material.dart';
import 'package:mimo/utils/constance.dart';

class SplashImage extends StatelessWidget {
  const SplashImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(Theme.of(context).brightness == Brightness.light
                    ? whiteSplash
                    : blackSplash,),
    );
  }
}