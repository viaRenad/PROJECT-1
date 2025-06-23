import 'package:adhan/adhan.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class PrayerTimeWidget extends StatefulWidget {
  const PrayerTimeWidget({super.key});

  @override
  State<PrayerTimeWidget> createState() => _PrayerTimeWidgetState();
}

class _PrayerTimeWidgetState extends State<PrayerTimeWidget> {
  late PrayerTimes prayerTimes;
  String nextPrayerName = '';
  Duration timeRemaining = Duration.zero;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    _loadPrayerTimes();
    _startTimer();
  }

  void _loadPrayerTimes() {
    final coordinates = Coordinates(21.3891, 39.8579); // مكة المكرمة
    final params = CalculationMethod.umm_al_qura.getParameters();
    final date = DateComponents.from(DateTime.now());
    prayerTimes = PrayerTimes(coordinates, date, params);

    _updateNextPrayer();
  }

  void _startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (_) => _updateNextPrayer());
  }

  void _updateNextPrayer() {
    final now = DateTime.now();
    final nextPrayer = prayerTimes.nextPrayer();
    final nextTime = prayerTimes.timeForPrayer(nextPrayer);

    setState(() {
      nextPrayerName = _getPrayerName(nextPrayer);
      timeRemaining = nextTime!.difference(now);
    });
  }

  String _getPrayerName(Prayer? prayer) {
    switch (prayer) {
      case Prayer.fajr:
        return 'الفجر';
      case Prayer.dhuhr:
        return 'الظهر';
      case Prayer.asr:
        return 'العصر';
      case Prayer.maghrib:
        return 'المغرب';
      case Prayer.isha:
        return 'العشاء';
      default:
        return 'لا توجد صلاة قادمة';
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hours = timeRemaining.inHours;
    final minutes = timeRemaining.inMinutes % 60;
    final seconds = timeRemaining.inSeconds % 60;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'الصلاة القادمة: $nextPrayerName',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        Text(
          'الوقت المتبقي: $hours ساعة و $minutes دقيقة و $seconds ثانية',
          style: TextStyle(fontSize: 18),
        ),
      ],
    );
  }
}
