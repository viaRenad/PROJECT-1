import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String hint;
  final bool obscureText;
  final TextInputType keyboardType;
  final TextEditingController controller;

  const CustomTextField({
    super.key,
    required this.label,
    required this.hint,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'Cairo',
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 3),
        SizedBox(
          width: 344,
          height: 56,
          child: TextField(
            cursorColor: Color(0xFF7E5A3B),
            controller: controller,
            textAlign: TextAlign.right,
            obscureText: obscureText,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                vertical: 16,
                horizontal: 20,
              ),
              hintText: hint,
              hintStyle: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 16,
                color: const Color.fromARGB(251, 158, 158, 158),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(27),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(28),
                borderSide: BorderSide(
                  color: const Color.fromARGB(133, 158, 158, 158),
                  width: 1,
                ),
              ),
              //لما يجي عليه فوكس
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(28),
                borderSide: BorderSide(color: Color(0xFF7E5A3B), width: 1),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
