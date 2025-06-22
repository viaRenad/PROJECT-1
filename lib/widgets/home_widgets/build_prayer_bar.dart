import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:mulabbi/widgets/home_widgets/prayer_item.dart';

class PrayerBar extends StatelessWidget {
  const PrayerBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28.0),
      child: SizedBox(
        height: 70.52,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: BackdropFilter(
            // very slight blur
            filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
            child: Container(
              decoration: BoxDecoration(
                // Semi-transparent background with gradient
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.0, 0.5, 1.0],
                  colors: [
                    Color.fromRGBO(0, 0, 0, 0.263), // 15% black
                    Color.fromRGBO(0, 0, 0, 0.037), // 5% black
                    Color.fromRGBO(0, 0, 0, 0.257), // 20% black
                  ],
                ),
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color: Color.fromRGBO(120, 59, 13, 1),
                  width: 1,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  // Subtle brown tint overlay
                  gradient: const LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Color.fromARGB(84, 75, 53, 34),
                      Color.fromARGB(84, 75, 53, 34),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      PrayerItem(
                        name: 'العشاء',
                        time: '4:56 AM',
                        iconPath: 'assets/images/isha.svg',
                      ),
                      PrayerItem(
                        name: 'المغرب',
                        time: '12:09 PM',
                        iconPath: 'assets/images/maghrib.svg',
                      ),
                      PrayerItem(
                        name: 'العصر',
                        time: '4:26 PM',
                        iconPath: 'assets/images/asr.svg',
                        isActive: true,
                      ),
                      PrayerItem(
                        name: 'الظهر',
                        time: '6:06 PM',
                        iconPath: 'assets/images/dhuhr.svg',
                      ),
                      PrayerItem(
                        name: 'الفجر',
                        time: '7:21 PM',
                        iconPath: 'assets/images/fajr.svg',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
