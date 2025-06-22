import 'package:flutter/material.dart';
import 'package:mulabbi/core/colors.dart';

class CustomLanguageSwitch extends StatelessWidget {
  final String selectedLanguage;
  final ValueChanged<String> onLanguageChanged;

  const CustomLanguageSwitch({
    super.key,
    required this.selectedLanguage,
    required this.onLanguageChanged,
  });

  @override
  Widget build(BuildContext context) {
    bool isArabic = selectedLanguage == 'ar';

    return GestureDetector(
      onTap: () {
        // Toggle between Arabic and English
        String newLanguage = isArabic ? 'en' : 'ar';
        onLanguageChanged(newLanguage);
      },
      child: Container(
        width: 68,
        height: 36,
        decoration: BoxDecoration(
          gradient: AppColorBrown.gradientBrown,
          borderRadius: BorderRadius.circular(40),
        ),
        child: Stack(
          children: [
            // Animated positioned circle
            AnimatedPositioned(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              left: isArabic ? 1 : 31,
              top: 1,
              child: Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: const Color(0xFFF5EFE8),
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFFBA9369), width: 2),
                ),
                child: Center(
                  child: Text(
                    isArabic ? 'ع' : 'EN',
                    style: TextStyle(
                      fontFamily: isArabic ? 'Cairo' : null,
                      fontSize: isArabic ? 13 : 12,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFFBA9369),
                    ),
                  ),
                ),
              ),
            ),
            // Background text labels
            Positioned(
              left: 8,
              top: 0,
              bottom: 0,
              child: Center(
                child: Text(
                  'ع',
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: isArabic ? Colors.transparent : Colors.white,
                  ),
                ),
              ),
            ),
            Positioned(
              right: 8,
              top: 0,
              bottom: 0,
              child: Center(
                child: Text(
                  'EN',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: !isArabic ? Colors.transparent : Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
