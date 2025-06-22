import 'package:flutter/material.dart';
import 'package:mulabbi/core/colors.dart';

class LanguageIconButton extends StatelessWidget {
  final VoidCallback onTap;
  const LanguageIconButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ShaderMask(
        shaderCallback: (bounds) => AppColorBrown.unlocked.createShader(bounds),
        blendMode: BlendMode.srcIn,
        child: const Icon(Icons.translate, size: 30),
      ),
    );
  }
}
