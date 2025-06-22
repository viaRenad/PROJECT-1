import 'package:flutter/material.dart';
import 'package:mulabbi/core/colors.dart';

class StartCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Gradient? gradient;
  final Color? backgroundColor;

  const StartCard({
    super.key,
    required this.title,
    required this.subtitle,
    this.gradient,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      padding: const EdgeInsets.only(right: 20, top: 16),
      decoration: BoxDecoration(
        color: backgroundColor,
        gradient: gradient,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.25), // 25% black
            offset: Offset(0, 2), // Y: 2
            blurRadius: 4,
          ),
        ],
      ),
      child: Stack(
        children: [
          // 🔠 Title + Subtitle (top right)
          Align(
            alignment: Alignment.topRight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                ShaderMask(
                  shaderCallback:
                      (bounds) => AppColorLight.fontLinear.createShader(bounds),
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 16.5,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                ShaderMask(
                  shaderCallback:
                      (bounds) =>
                          AppColorLight.fontSoftWhite.createShader(bounds),
                  child: Text(
                    subtitle,
                    style: const TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 11,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ➕ Icon (top left)
          Positioned(
            top: -3,
            left: 20,
            child: ShaderMask(
              shaderCallback:
                  (bounds) => AppColorLight.fontLinear.createShader(bounds),
              child: Icon(
                Icons.add,
                size: 35,
                color: Colors.white,
                shadows: const [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.25), // 25% black
                    offset: Offset(0, 4), // X: 0, Y: 4
                    blurRadius: 4,
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
