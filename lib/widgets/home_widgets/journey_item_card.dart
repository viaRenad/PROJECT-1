import 'package:flutter/material.dart';
import 'package:mulabbi/core/colors.dart';

class JourneyItemCard extends StatelessWidget {
  final String title;
  final String imagePath;
  final double imageBottomOffset;
  final double imageHeight;
  final VoidCallback? onTap; // 🆕 Add this line

  const JourneyItemCard({
    super.key,
    required this.title,
    required this.imagePath,
    this.imageBottomOffset = 0.0,
    this.imageHeight = 89.0,
    this.onTap, // 🆕 Also here
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // 🆕 Wrap the whole card to handle taps
      onTap: onTap,
      child: Container(
        width: 116,
        height: 154,
        decoration: BoxDecoration(
          color: const Color(0xFFEBE4D9),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: const Color.fromRGBO(218, 201, 178, 0.70),
            width: 3,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              blurRadius: 4,
              offset: const Offset(4, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            const SizedBox(height: 14),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2),
              child: ShaderMask(
                shaderCallback:
                    (bounds) => AppColorBrown.gradientPrimary.createShader(
                      Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                    ),
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Required for gradient to apply
                  ),
                ),
              ),
            ),
            const Spacer(),
            Transform.translate(
              offset: Offset(0, -imageBottomOffset),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
                child: Image.asset(
                  imagePath,
                  height: imageHeight,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
