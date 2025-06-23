import 'package:flutter/material.dart';
import 'package:mulabbi/models/adhkar_model.dart';

class ContentItemCard extends StatelessWidget {
  final ContentItem adhkarItem;

  const ContentItemCard({super.key, required this.adhkarItem});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(bottom: 12),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Color(0xFFEAE2D6),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Category header
                // Dua text
                Text(
                  adhkarItem.text,
                  style: TextStyle(
                    fontFamily:
                        'Hafs', // ✅ Use the font family defined in pubspec.yaml
                    fontSize: 18,
                    color: Color(0xFF7E5A3B),
                    height: 1.7,
                  ),
                  textAlign: TextAlign.right,
                  textDirection: TextDirection.rtl,
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              margin: EdgeInsets.only(bottom: 12),
              child: Text(
                adhkarItem.repeat,
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: 'AlNile',
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF7E5A3B),
                ),
                textAlign: TextAlign.right,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
