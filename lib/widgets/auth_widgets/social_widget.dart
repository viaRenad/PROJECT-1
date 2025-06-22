import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SocialIconButton extends StatelessWidget {
  final VoidCallback onTap;
  final String imagePath;

  const SocialIconButton({
    super.key,
    required this.onTap,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(30),
      onTap: onTap,
      child: Container(
        width: 55,
        height: 38,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(77)),
          shape: BoxShape.rectangle,
          border: Border.all(color: Color(0xFF7E5A3B), width: 2),
        ),
        child:
            imagePath.endsWith('.svg')
                ? SvgPicture.asset(imagePath, width: 14, height: 14)
                : Image.asset(imagePath, width: 14, height: 14),
      ),
    );
  }
}
