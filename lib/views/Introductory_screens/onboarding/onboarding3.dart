import 'package:flutter/material.dart';
import 'package:mulabbi/core/colors.dart';
import 'package:mulabbi/views/Introductory_screens/welcome_screen.dart';
import 'package:mulabbi/widgets/introductory_screens_widgets/language_icon_button.dart';
import 'package:mulabbi/widgets/introductory_screens_widgets/language_dialog.dart';

class OnboardingPage3 extends StatelessWidget {
  const OnboardingPage3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 🔹 Background image
          Positioned.fill(
            child: Image.asset(
              'assets/images/onboarding3.png',
              fit: BoxFit.contain,
            ),
          ),

          // 🔹 Foreground content
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // 🔸 Top row with language icon only
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 33,
                    vertical: 20,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      LanguageIconButton(
                        onTap: () => showLanguageDialog(context),
                      ),
                    ],
                  ),
                ),

                // 🔽 Title area
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 33),
                  child: ShaderMask(
                    shaderCallback:
                        (bounds) => AppColorBrown.unlocked.createShader(
                          Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                        ),
                    blendMode: BlendMode.srcIn,
                    child: const Text(
                      'استكشف زاد... مكتبة\nمتكاملة لمساعدتك قبل وأثناء الرحلة',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Cairo',
                        color: Colors.white,
                        height: 1.5,
                      ),
                    ),
                  ),
                ),

                const Spacer(),

                // 🔸 Matching "ابدأ" Button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 33),
                  child: Container(
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
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const WelcomeScreen(),
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
                        'ابدأ',
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          height: 1.5,
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
                ),

                const SizedBox(height: 46),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
