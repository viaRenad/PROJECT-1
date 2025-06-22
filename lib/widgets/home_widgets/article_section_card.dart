import 'package:flutter/material.dart';
import 'package:mulabbi/core/colors.dart';

class ArticleSectionCard extends StatelessWidget {
  final int number;
  final String title;
  final List<String> items;

  const ArticleSectionCard({
    super.key,
    required this.number,
    required this.title,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16, right: 8, left: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // 🔶 Title Card (number on the RIGHT side)
          Container(
            height: 50,
            decoration: BoxDecoration(
              color: const Color(0xFFEBE4D9),
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  offset: Offset(0, 3),
                  blurRadius: 6,
                ),
              ],
            ),
            child: Row(
              children: [
                // 🔹 Title text (now on the left)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: ShaderMask(
                      shaderCallback:
                          (bounds) => AppColorBrown.gradientBrown.createShader(
                            Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                          ),
                      blendMode: BlendMode.srcIn,
                      child: Text(
                        title,
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Cairo',
                          color:
                              Colors.white, // will be replaced by the gradient
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                // 🔸 Number Badge (now on the right)
                Container(
                  width: 29,
                  height: double.infinity,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    gradient: AppColorBrown.diagonal,
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                  ),
                  child: Text(
                    '$number',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'Cairo',
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // 🔹 Bullet Items
          ...items.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                textDirection: TextDirection.rtl,
                children: [
                  const Text(
                    '• ',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Cairo',
                      color: Color(0xFF6A370B), // ✅ new color
                    ),
                  ),

                  const SizedBox(width: 8),

                  Expanded(
                    child: Text(
                      item,
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        fontSize: 14.5,
                        fontFamily: 'Cairo',
                        height: 1.5,
                        color: Color(0xFF6A370B), // ✅ new color
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
