import 'package:flutter/material.dart';
import 'package:mulabbi/core/colors.dart';

class CustomSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const CustomSwitch({required this.value, required this.onChanged, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: Container(
        width: 68,
        height: 36,
        decoration: BoxDecoration(
          gradient: AppColorBrown.gradientBrown,
          borderRadius: BorderRadius.circular(40),
        ),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: const Color(0xFFF5EFE8),
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFFBA9369), width: 2),
              ),
              child: const Center(
                child: Icon(
                  Icons.notifications_none_rounded,
                  color: Color(0xFFBA9369),
                  size: 25,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
