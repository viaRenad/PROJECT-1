import 'package:flutter/material.dart';
import 'custom_language_switch.dart';

class LanguageRow extends StatelessWidget {
  final String selectedLanguage;
  final ValueChanged<String> onLanguageChanged;

  const LanguageRow({
    super.key,
    required this.selectedLanguage,
    required this.onLanguageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          const Icon(Icons.translate, color: Color(0xFF7E573B)),
          const SizedBox(width: 12),
          const Text(
            'اللغة',
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Spacer(),
          CustomLanguageSwitch(
            selectedLanguage: selectedLanguage,
            onLanguageChanged: onLanguageChanged,
          ),
        ],
      ),
    );
  }
}
