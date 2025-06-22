import 'package:flutter/material.dart';

class TopicWidget extends StatelessWidget {
  final String topicTitle;
  final String imagePath;
  final String Category;
  final VoidCallback onTap;

  const TopicWidget({
    super.key,
    required this.topicTitle,
    required this.imagePath,
    required this.Category,
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
        width: 151,
        height: 215,
        decoration: const BoxDecoration(
          color: Color.fromARGB(0, 252, 248, 171),
        ),
        child: Column(
          children: [
            Container(
              width: 139,
              height: 122,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.only(right: 7),
              child: Align(
                alignment: Alignment.centerRight,
                child: Container(
                  width: 50,
                  height: 20,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8D9C4),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      Category,
                      style: const TextStyle(
                        fontSize: 10,
                        color: Colors.black,
                        fontFamily: 'Cairo',
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 1),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                width: 140,
                height: 60,
                padding: const EdgeInsets.all(8),
                child: Text(
                  topicTitle,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontFamily: 'Cairo',
                  ),
                  textAlign: TextAlign.right,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
