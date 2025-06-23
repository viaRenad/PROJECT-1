import 'package:flutter/material.dart';
import 'package:mulabbi/views/tools_views/adhkar_view.dart';
import 'package:mulabbi/views/tools_views/adiyah_view.dart';
import 'package:mulabbi/views/tools_views/haramain_live_view.dart';
import 'package:mulabbi/views/tools_views/misbaha_view.dart';
import 'package:mulabbi/views/tools_views/qibla_screen.dart';
import 'package:mulabbi/views/tools_views/quran%20view/quran_view.dart';
import 'package:mulabbi/widgets/home_widgets/journey_item_card.dart';
import 'package:mulabbi/core/colors.dart';

class JourneyAttachments extends StatelessWidget {
  const JourneyAttachments({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // 🏷 Section title
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(), // pushes title to right
              ShaderMask(
                shaderCallback:
                    (bounds) => AppColorBrown.unlocked.createShader(bounds),
                blendMode: BlendMode.srcIn,
                child: const Text(
                  'مرفقات الرحلة',
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),

        // 🧳 Journey tools grid
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Wrap(
            alignment: WrapAlignment.center,
            runAlignment: WrapAlignment.center,
            spacing: 12,
            runSpacing: 24,
            direction: Axis.horizontal,
            children: [
              JourneyItemCard(
                title: 'القبلة',
                imagePath: 'assets/images/qibla.png',
                imageHeight: 99,
                imageBottomOffset: 2,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const QiblaCompass()),
                  );
                },
              ),

              JourneyItemCard(
                title: 'المسبحة',
                imagePath: 'assets/images/masbaha.png',
                imageHeight: 110,
                imageBottomOffset: -7,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const MisbahaView()),
                  );
                },
              ),

              JourneyItemCard(
                title: 'المصحف',
                imagePath: 'assets/images/quran.png',
                imageHeight: 91,
                imageBottomOffset: 0,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const QuranPageView()),
                  );
                },
              ),

              JourneyItemCard(
                title: 'بث الحرمين',
                imagePath: 'assets/images/broadcast.png',
                imageHeight: 75,
                imageBottomOffset: 0,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const HaramBroadcastPage(),
                    ),
                  );
                },
              ),

              JourneyItemCard(
                title: 'الأذكار',
                imagePath: 'assets/images/azkar.png',
                imageHeight: 90,
                imageBottomOffset: 5,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => AdhkarView()),
                  );
                },
              ),

              JourneyItemCard(
                title: 'أدعية',
                imagePath: 'assets/images/dua.png',
                imageHeight: 100,
                imageBottomOffset: -6,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const DuasPage()),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
