import 'package:flutter/material.dart';

class FaqPage extends StatelessWidget {
  const FaqPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الأسئلة الشائعة'),
        backgroundColor: const Color(0xFF7E573B),
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          ExpansionTile(
            title: Text("كيف أسجل الدخول؟"),
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "يمكنك تسجيل الدخول باستخدام بريدك الإلكتروني وكلمة المرور.",
                ),
              ),
            ],
          ),
          ExpansionTile(
            title: Text("كيف أبدأ رحلتي؟"),
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "بعد تسجيل الدخول، اختر نوع الرحلة من الصفحة الرئيسية.",
                ),
              ),
            ],
          ),
          ExpansionTile(
            title: Text("هل التطبيق يعمل بدون إنترنت؟"),
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "بعض المزايا تحتاج الاتصال بالإنترنت، مثل تسجيل الدخول.",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
