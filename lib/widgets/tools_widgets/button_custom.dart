import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? color; // ✅ make optional
  final Gradient? gradient; // ✅ new

  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.color,
    this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        gradient: gradient,
        borderRadius: BorderRadius.circular(66),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent, // ✅ no solid color
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(66),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
            shadows: [
              Shadow(
                offset: Offset(2, 2), // horizontal & vertical offset
                blurRadius: 2, // soft blur
                color: Color.fromARGB(149, 0, 0, 0), // shadow color
              ),
            ],
          ),
        ),
      ),
    );
  }
}
