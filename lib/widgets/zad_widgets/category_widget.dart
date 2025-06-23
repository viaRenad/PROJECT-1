import 'package:flutter/material.dart';

class CategoryWidget extends StatelessWidget {
  final String title;
  final String imagePath;
  final VoidCallback onTap;
  final double width;
  final double heigth;
  const CategoryWidget({
    super.key,
    required this.title,
    required this.imagePath,
    required this.onTap,
    required this.width,
    required this.heigth,
  });

  @override
  Widget build(BuildContext context) {
    ImageProvider imageProvider;
    if (imagePath.startsWith('http') || imagePath.startsWith('https')) {
      imageProvider = NetworkImage(imagePath);
    } else {
      imageProvider = AssetImage(imagePath);
    }
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 118,
        height: 110,
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
        padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Spacer(),
            Text(
              title,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Color(0xFF7E5A3B),
                fontFamily: 'Cairo',
              ),
              textAlign: TextAlign.center,
            ),
            Spacer(),
            Image(image: imageProvider, width: width, height: heigth),
          ],
        ),
      ),
    );
  }
}
