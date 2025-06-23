import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:adhan/adhan.dart';
import 'prayer_item.dart';

class PrayerBar extends StatefulWidget {
  const PrayerBar({super.key});

  @override
  _PrayerBarState createState() => _PrayerBarState();
}

class _PrayerBarState extends State<PrayerBar> {
  late PrayerTimes _times;
  Timer? _timer;

  // map Arabic name → asset filename
  static const _iconMap = {
    'الفجر': 'assets/images/fajr.svg',
    'الظهر': 'assets/images/dhuhr.svg',
    'العصر': 'assets/images/asr.svg',
    'المغرب': 'assets/images/maghrib.svg',
    'العشاء': 'assets/images/isha.svg',
  };

  @override
  void initState() {
    super.initState();
    _calculatePrayerTimes();
    // rebuild every minute so the active pointer moves on time
    _timer = Timer.periodic(const Duration(minutes: 1), (_) {
      setState(() {});
    });
  }

  void _calculatePrayerTimes() {
    // replace with real coords if you like
    final coords = Coordinates(21.4225, 39.8262);
    final params = CalculationMethod.muslim_world_league.getParameters();
    _times = PrayerTimes(coords, DateComponents.from(DateTime.now()), params);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final prayers =
        <String, DateTime>{
          'الفجر': _times.fajr,
          'الظهر': _times.dhuhr,
          'العصر': _times.asr,
          'المغرب': _times.maghrib,
          'العشاء': _times.isha,
        }.entries.toList();

    // find the next one (or wrap to الفجر)
    int nextIndex = prayers.indexWhere((e) => e.value.isAfter(now));
    if (nextIndex < 0) nextIndex = 0;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28.0),
      child: SizedBox(
        height: 70.52,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
            child: Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.0, 0.5, 1.0],
                  colors: [
                    Color.fromRGBO(0, 0, 0, 0.263),
                    Color.fromRGBO(0, 0, 0, 0.037),
                    Color.fromRGBO(0, 0, 0, 0.257),
                  ],
                ),
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color: const Color.fromRGBO(120, 59, 13, 1),
                  width: 1,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
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
                    // Ensure Arabic right-to-left layout
                    textDirection: TextDirection.rtl,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(prayers.length, (i) {
                      final name = prayers[i].key;
                      final time = TimeOfDay.fromDateTime(
                        prayers[i].value,
                      ).format(context);
                      final isActive = i == nextIndex;
                      return PrayerItem(
                        name: name,
                        time: time,
                        iconPath: _iconMap[name]!,
                        isActive: isActive,
                      );
                    }),
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
