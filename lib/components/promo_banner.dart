import 'package:flutter/material.dart';

class PromoBanner extends StatelessWidget {
  final String imagePath;
  final VoidCallback onTap;
  const PromoBanner({super.key, required this.onTap, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(40),
          child: Image.asset(
            imagePath,
            fit: BoxFit.fill,
            height: 160,
            width: double.infinity,
          ),
        ),
      ),
    );
  }
}
