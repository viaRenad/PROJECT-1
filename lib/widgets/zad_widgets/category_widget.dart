import 'package:flutter/material.dart';

class CategoryWidget extends StatelessWidget {
  final String title;
  final String imagePath;
  final VoidCallback onTap;
  const CategoryWidget({
    super.key,
    required this.title,
    required this.imagePath,
    required this.onTap,
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
        width: 130,
        height: 120,
        decoration: BoxDecoration(
          color: const Color.fromARGB(174, 227, 224, 208),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Color.fromARGB(255, 192, 174, 160),
            width: 2,
          ),
          shape: BoxShape.rectangle,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
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
            Image(
              image: imageProvider,
              width: 130,
              height: 60,
              fit: BoxFit.contain,
            ),
          ],
        ),
      ),
    );
  }
}
