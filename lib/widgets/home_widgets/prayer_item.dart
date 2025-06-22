import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PrayerItem extends StatelessWidget {
  final String name;
  final String time;
  final String iconPath;
  final bool isActive;

  const PrayerItem({
    super.key,
    required this.name,
    required this.time,
    required this.iconPath,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    final Color textColor =
        isActive ? Colors.white : Colors.white.withOpacity(0.80);

    return SizedBox(
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          // Prayer content
          Transform.translate(
            offset: const Offset(0, -5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    color: textColor,
                    fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                    fontSize: 12,
                  ),
                ),
                iconPath.endsWith('.svg')
                    ? SvgPicture.asset(
                      iconPath,
                      width: 20,
                      height: 20,
                      color: textColor,
                    )
                    : Image.asset(
                      iconPath,
                      width: 20,
                      height: 20,
                      color: textColor,
                    ),
                Text(
                  time,
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    color: textColor,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),

          // Pointer overlay
          if (isActive)
            const Positioned(
              top: 46,
              left: 0,
              right: 0,
              child: Image(
                image: AssetImage('assets/images/pointer.png'),
                width: 25,
                height: 25,
              ),
            ),
        ],
      ),
    );
  }
}
