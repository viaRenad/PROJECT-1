import 'package:flutter/material.dart';
import 'package:mulabbi/core/colors.dart';

class GuestTrack extends StatelessWidget {
  const GuestTrack({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 🖼️ Full background image
          Positioned.fill(
            child: Image.asset(
              'assets/images/guest_track.png',
              fit: BoxFit.cover,
            ),
          ),

          // 🧍 Content centered on screen
          Align(
            alignment: const Alignment(0, 0.2),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return AppColorBrown.unlocked.createShader(bounds);
                    },
                    blendMode: BlendMode.srcIn,
                    child: const Text(
                      'تحتاج الى تسجيل الدخول',
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  const SizedBox(height: 12),

                  // 🧾 Subtext
                  const Text(
                    'سجل دخولك لمتابعة مناسكك \nخطوة بخطوة عند بدء رحلتك',
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 16,
                      height: 1.7,
                      color: Color.fromARGB(255, 43, 43, 43),
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 20),

                  // 🔘 Gradient login button with shadowed + gradient text
                  Container(
                    width: 246,
                    height: 58,
                    decoration: BoxDecoration(
                      gradient: AppColorBrown.gradientBrown,
                      borderRadius: BorderRadius.circular(66),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12.5,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(66),
                        ),
                      ),
                      onPressed: () {
                        // TODO: Handle login navigation
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // Drop shadow text
                          const Text(
                            'تسجيل الدخول',
                            style: TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black54,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          // Gradient masked text
                          ShaderMask(
                            shaderCallback: (bounds) {
                              return AppColorLight.fontLinear.createShader(
                                bounds,
                              );
                            },
                            blendMode: BlendMode.srcIn,
                            child: const Text(
                              'تسجيل الدخول',
                              style: TextStyle(
                                fontFamily: 'Cairo',
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white, // ignored
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 11),

                  // ➕ Create account
                  GestureDetector(
                    onTap: () {
                      // TODO: Navigate to sign up
                    },
                    child: const Text(
                      'إنشاء حساب جديد',
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 14.5,
                        color: Color(0xFF734218),
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.w500,
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
