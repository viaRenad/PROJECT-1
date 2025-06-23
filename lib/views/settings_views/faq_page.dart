import 'package:flutter/material.dart';
import 'package:mulabbi/core/colors.dart';

class FaqPage extends StatelessWidget {
  const FaqPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F2EE),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: const BoxDecoration(
            gradient: AppColorBrown.gradientBrown,
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            title: const Text(
              'الأسئلة الشائعة',
              style: TextStyle(
                fontFamily: 'Cairo',
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            foregroundColor: Colors.white,
          ),
        ),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: const [
            _FaqTile(
              question: "كيف أسجل الدخول؟",
              answer:
                  "يمكنك تسجيل الدخول باستخدام بريدك الإلكتروني وكلمة المرور.",
              icon: Icons.login,
            ),
            Divider(),
            _FaqTile(
              question: "كيف أبدأ رحلتي؟",
              answer: "بعد تسجيل الدخول، اختر نوع الرحلة من الصفحة الرئيسية.",
              icon: Icons.travel_explore,
            ),
            Divider(),
            _FaqTile(
              question: "هل التطبيق يعمل بدون إنترنت؟",
              answer: "بعض المزايا تحتاج الاتصال بالإنترنت، مثل تسجيل الدخول.",
              icon: Icons.wifi_off,
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}

class _FaqTile extends StatefulWidget {
  final String question;
  final String answer;
  final IconData icon;

  const _FaqTile({
    required this.question,
    required this.answer,
    required this.icon,
  });

  @override
  State<_FaqTile> createState() => _FaqTileState();
}

class _FaqTileState extends State<_FaqTile> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () => setState(() => isExpanded = !isExpanded),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: Row(
              children: [
                Icon(widget.icon, color: const Color(0xFF7E573B), size: 24),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    widget.question,
                    style: const TextStyle(
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
                const SizedBox(width: 8),
                Icon(
                  isExpanded
                      ? Icons.keyboard_arrow_down
                      : Icons.keyboard_arrow_right,
                  color: const Color(0xFF7E573B),
                ),
              ],
            ),
          ),
        ),
        if (isExpanded)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Text(
              widget.answer,
              style: const TextStyle(
                fontFamily: 'Cairo',
                fontSize: 15,
                height: 1.6,
                color: Colors.black87,
              ),
              textAlign: TextAlign.right,
            ),
          ),
      ],
    );
  }
}
