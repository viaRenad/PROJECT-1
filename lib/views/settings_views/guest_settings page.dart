import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mulabbi/core/colors.dart';
import 'package:mulabbi/views/auth/login_page.dart';
import 'package:mulabbi/views/auth/singup_page.dart';

class GuestSettingsPage extends StatelessWidget {
  const GuestSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F7F4),
      body: Column(
        children: [
          // 🟤 Profile Header with circular gradient and bottom-only visible border
          Stack(
            children: [
              // 🟡 Stroke layer
              ClipPath(
                clipper: ArcClipper(),
                child: Container(
                  height: 345,
                  color: const Color(0xFFE0D1B5), // stroke color
                ),
              ),

              // 🟤 Gradient layer
              ClipPath(
                clipper: ArcClipper(),
                child: Container(
                  height: 320,
                  decoration: const BoxDecoration(
                    gradient: AppColorBrown.diagonal,
                  ),
                ),
              ),

              // 👤 Profile Avatar
              Positioned.fill(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 166),
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        const CircleAvatar(
                          radius: 65,
                          backgroundColor: Color.fromARGB(255, 255, 253, 253),
                          child: Icon(
                            Icons.person,
                            size: 90,
                            color: Color.fromARGB(255, 165, 120, 89),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 40),

          // ⬜ White card with login button
          Center(
            child: Container(
              width: 360,
              padding: const EdgeInsets.symmetric(vertical: 70),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(45),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.17),
                    blurRadius: 12,
                    offset: const Offset(3, 3),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // 📝 Top text (NO horizontal padding)
                  const Text(
                    'لم تقم بتسجيل الدخول',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF7E573B),
                    ),
                  ),
                  const SizedBox(height: 28),

                  // ✅ Wrap only this part with horizontal padding
                  InkWell(
                    onTap: () {
                      Get.to(() => LoginScreen());
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 95),
                      child: Column(
                        children: [
                          // 🔘 Gradient login button
                          Container(
                            width: double.infinity,
                            height: 46,
                            decoration: BoxDecoration(
                              gradient: AppColorBrown.gradientBrown,
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.25),
                                  blurRadius: 6,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                'تسجيل الدخول',
                                style: TextStyle(
                                  fontFamily: 'Cairo',
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  shadows: [
                                    Shadow(
                                      color: Colors.black.withOpacity(0.30),
                                      offset: const Offset(0, 3),
                                      blurRadius: 1,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 10),

                          // ➕ Create account link
                          GestureDetector(
                            onTap: () {
                              Get.to(() => SingupPage());
                            },
                            child: const Text(
                              "إنشاء حساب جديد",
                              style: TextStyle(
                                fontSize: 13,
                                color: Color(0xFF734218),
                                decoration: TextDecoration.underline,
                                decorationColor: Color(0xFF734218),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ArcClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    final double height = size.height;
    final double width = size.width;

    path.lineTo(0, height - 110);
    path.quadraticBezierTo(
      width / 2,
      height + 50, // ⬅️ Increase this value to make it rounder
      width,
      height - 110,
    );
    path.lineTo(width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
