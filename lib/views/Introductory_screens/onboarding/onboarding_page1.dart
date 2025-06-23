import 'package:flutter/material.dart';
import 'package:mulabbi/core/colors.dart';
import 'package:mulabbi/views/Introductory_screens/onboarding/onboarding_page2.dart';
import 'package:mulabbi/views/Introductory_screens/welcome_screen.dart';

class OnboardingPage1 extends StatelessWidget {
  const OnboardingPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned.fill(child: Image.asset('assets/images/onboarding1.png')),

          // Overlay content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 33, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // 🔼 Top Row: Language + Skip
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const WelcomeScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          'تخطي',
                          style: TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 18,
                            decoration: TextDecoration.underline,
                            color: Color(0xFF734218),
                          ),
                        ),
                      ),
                    ],
                  ),

                  // 🔽 Expandable space to place title freely
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(height: 30),
                        ShaderMask(
                          shaderCallback:
                              (bounds) => AppColorBrown.unlocked.createShader(
                                Rect.fromLTWH(
                                  0,
                                  0,
                                  bounds.width,
                                  bounds.height,
                                ),
                              ),
                          blendMode: BlendMode.srcIn,
                          child: const Text(
                            'رحلة مناسكك خطوة بخطوة',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontSize: 34,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Cairo',
                              color: Colors.white,
                              height: 1.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // ✅ Button
                  Container(
                    height: 62,
                    decoration: BoxDecoration(
                      gradient: AppColorBrown.unlocked,
                      borderRadius: BorderRadius.circular(66),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromARGB(87, 0, 0, 0),
                          blurRadius: 2,
                          offset: Offset(4, 4),
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const OnboardingPage2(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(66),
                        ),
                      ),
                      child: const Text(
                        'المتابعة',
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontWeight: FontWeight.bold,
                          fontSize: 19,
                          height: 1.5,
                          letterSpacing: 0,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              color: Color.fromARGB(73, 0, 0, 0),
                              offset: Offset(2, 4),
                              blurRadius: 1,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
