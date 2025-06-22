import 'package:flutter/material.dart';
import 'package:mulabbi/models/nusk_details.dart';

class TrackDetailDescription extends StatelessWidget {
  const TrackDetailDescription({super.key, required this.detail});

  final Details detail;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(6),
      child: RichText(
        textDirection: TextDirection.rtl,
        text: TextSpan(
          children: [
            TextSpan(
              text: "${detail.highlight} ",
              style: TextStyle(
                fontSize: 14,
                fontFamily: "Cairo",
                fontWeight: FontWeight.bold,
                color: Color(0xFF734218),
              ),
            ),
            TextSpan(
              text: detail.description,
              style: TextStyle(
                fontSize: 12,
                color: Color(0xFF333333),
                fontFamily: "Cairo",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
