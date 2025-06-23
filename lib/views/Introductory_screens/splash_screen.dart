import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mulabbi/views/Introductory_screens/is_new_user_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 1500), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => IsNewUserScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F2EE), // Match image background
      body: Center(
        child: Image.asset(
          'assets/images/splash.png',
          width: 1500, // Adjust if needed
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
