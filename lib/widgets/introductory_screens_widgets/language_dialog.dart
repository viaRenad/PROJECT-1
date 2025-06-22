import 'package:flutter/material.dart';
import 'package:mulabbi/core/colors.dart';

void showLanguageDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF8F4ED),
            borderRadius: BorderRadius.circular(25),
            border: Border.all(color: const Color(0xFF7E5A3B), width: 2),
            boxShadow: const [
              BoxShadow(
                color: Color.fromARGB(76, 0, 0, 0),
                offset: Offset(0, 6),
                blurRadius: 12,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: ShaderMask(
                    shaderCallback:
                        (bounds) => AppColorBrown.unlocked.createShader(
                          Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                        ),
                    blendMode: BlendMode.srcIn,
                    child: const Text(
                      'اختر اللغة',
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                LanguageOption(
                  flagEmoji: '🇸🇦',
                  label: 'العربية',
                  onTap: () {
                    // TODO: Set Arabic
                    Navigator.pop(context);
                  },
                ),
                const SizedBox(height: 12),
                LanguageOption(
                  flagEmoji: '🇺🇸',
                  label: 'English',
                  onTap: () {
                    // TODO: Set English
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

class LanguageOption extends StatelessWidget {
  final String flagEmoji;
  final String label;
  final VoidCallback onTap;

  const LanguageOption({
    super.key,
    required this.flagEmoji,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFF7E5A3B), width: 1),
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(50, 0, 0, 0),
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Text(flagEmoji, style: const TextStyle(fontSize: 28)),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                textAlign: TextAlign.right,
                style: const TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF7E5A3B),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
