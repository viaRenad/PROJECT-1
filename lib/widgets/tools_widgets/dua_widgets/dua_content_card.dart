import 'package:flutter/material.dart';
import 'package:mulabbi/models/dua_model.dart';

class ContentItemCard extends StatelessWidget {
  final ContentItem duaItem;

  const ContentItemCard({super.key, required this.duaItem});

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
                  duaItem.text,
                  style: TextStyle(
                    fontSize: 17,
                    color: Color(0xFF7E5A3B),
                    height: 1.8,
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
                duaItem.title,
                style: TextStyle(
                  fontSize: 15,
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
