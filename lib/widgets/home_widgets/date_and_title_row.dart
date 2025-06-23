import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:mulabbi/controllers/track_controller.dart';
import 'package:mulabbi/core/colors.dart';

class DateAndTitleRow extends StatefulWidget {
  const DateAndTitleRow({super.key});

  @override
  State<DateAndTitleRow> createState() => _DateAndTitleRowState();
}

class _DateAndTitleRowState extends State<DateAndTitleRow>
    with SingleTickerProviderStateMixin {
  bool showHijri = true;

  late HijriCalendar _hijriDate;
  late DateTime _gregorianDate;

  late final AnimationController _controller;
  late final Animation<double> _rotation;

  @override
  void initState() {
    super.initState();
    _gregorianDate = DateTime.now();
    HijriCalendar.setLocal("ar");
    _hijriDate = HijriCalendar.now();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _rotation = Tween<double>(
      begin: 1.0,
      end: 0.5,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleCalendar() {
    _controller.forward(from: 0.0); // rotate icon
    setState(() {
      showHijri = !showHijri;
    });
  }

  @override
  Widget build(BuildContext context) {
    final hijriDay = _hijriDate.hDay;
    final hijriMonth = _hijriDate.getLongMonthName();
    final hijriYear = _hijriDate.hYear;

    final gregorianDay = _gregorianDate.day;
    final gregorianMonth = _gregorianDate.month;
    final gregorianYear = _gregorianDate.year;
    late final trackController = Get.put(TrackController());

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // 🔄 Date + toggle
          Row(
            children: [
              GestureDetector(
                onTap: _toggleCalendar,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    gradient: AppColorBrown.hajj,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Row(
                    children: [
                      RotationTransition(
                        turns: _rotation,
                        child: const Icon(
                          Icons.cached,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        showHijri ? '$hijriYear' : '$gregorianYear',
                        style: const TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                showHijri
                    ? '$hijriDay $hijriMonth'
                    : '$gregorianDay ${_getArabicMonthName(gregorianMonth)}',
                textDirection: TextDirection.rtl,
                style: const TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),

          // 📍 Title
          ShaderMask(
            shaderCallback:
                (bounds) => AppColorBrown.unlocked.createShader(
                  Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                ),
            blendMode: BlendMode.srcIn,
            child: Text(
              !trackController.isTrackActive
                  ? 'اختر نُسُكك لبدء رحلتك'
                  : "النسك الحالي",
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getArabicMonthName(int month) {
    const arabicMonths = [
      "يناير",
      "فبراير",
      "مارس",
      "أبريل",
      "مايو",
      "يونيو",
      "يوليو",
      "أغسطس",
      "سبتمبر",
      "أكتوبر",
      "نوفمبر",
      "ديسمبر",
    ];
    return arabicMonths[month - 1];
  }
}
