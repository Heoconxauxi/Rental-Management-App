import 'package:flutter/material.dart';
import 'package:rental_management_app/core/constants/assets_manager.dart';

class BackgroundGradient extends StatelessWidget {
  final Widget child;

  const BackgroundGradient({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(ImageAssets.backgroundgradient),
          fit: BoxFit.cover,
          opacity: 0.5,
        ),
      ),
      child: child,
    );
  }
}