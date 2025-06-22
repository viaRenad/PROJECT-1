import 'package:flutter/material.dart';
import 'package:mulabbi/core/colors.dart';
import 'package:mulabbi/views/Introductory_screens/onboarding/onboarding3.dart';
import 'package:mulabbi/views/Introductory_screens/welcome_screen.dart';
import 'package:mulabbi/widgets/introductory_screens_widgets/language_icon_button.dart';
import 'package:mulabbi/widgets/introductory_screens_widgets/language_dialog.dart';

class OnboardingPage2 extends StatefulWidget {
  const OnboardingPage2({super.key});

  @override
  State<OnboardingPage2> createState() => _OnboardingPage2State();
}

class _OnboardingPage2State extends State<OnboardingPage2> {
  bool showCards = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() => showCards = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 🔹 Background
          Positioned.fill(
            child: Image.asset(
              'assets/images/onboarding2.png',
              fit: BoxFit.contain,
            ),
          ),

          // 🔹 Foreground content
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // 🔹 Top row
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 33,
                    vertical: 20,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      LanguageIconButton(
                        onTap: () => showLanguageDialog(context),
                      ),
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
                ),

                // 🔹 Title
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 33),
                  child: ShaderMask(
                    shaderCallback:
                        (bounds) => AppColorBrown.unlocked.createShader(
                          Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                        ),
                    blendMode: BlendMode.srcIn,
                    child: const Text(
                      'كل ما تحتاجه لإتمام\nرحلتك بين يديك',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 33,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Cairo',
                        color: Colors.white,
                        height: 1.5,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // 🔹 Animated Cards
                Expanded(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Quran Card
                      Positioned(
                        top: 20,
                        left: 0,
                        child: TweenAnimationBuilder<Offset>(
                          duration: const Duration(milliseconds: 1000),
                          curve: Curves.easeOut,
                          tween: Tween(
                            begin: const Offset(0, -80),
                            end: Offset.zero,
                          ),
                          builder:
                              (context, value, child) => Transform.translate(
                                offset: value,
                                child: Opacity(
                                  opacity: 1 - (value.dy.abs() / 80),
                                  child: child,
                                ),
                              ),
                          child: Image.asset(
                            'assets/images/quranx.png',
                            width: 297,
                          ),
                        ),
                      ),

                      // Qibla Card
                      Positioned(
                        bottom: 0,
                        left: 100,
                        child: TweenAnimationBuilder<Offset>(
                          duration: const Duration(milliseconds: 1300),
                          curve: Curves.easeOut,
                          tween: Tween(
                            begin: const Offset(0, -80),
                            end: Offset.zero,
                          ),
                          builder:
                              (context, value, child) => Transform.translate(
                                offset: value,
                                child: Opacity(
                                  opacity: 1 - (value.dy.abs() / 80),
                                  child: child,
                                ),
                              ),
                          child: Image.asset(
                            'assets/images/qiblax.png',
                            width: 330,
                          ),
                        ),
                      ),

                      // Seb7a Card
                      Positioned(
                        top: 80,
                        right: 0,
                        child: TweenAnimationBuilder<Offset>(
                          duration: const Duration(milliseconds: 1150),
                          curve: Curves.easeOut,
                          tween: Tween(
                            begin: const Offset(0, -80),
                            end: Offset.zero,
                          ),
                          builder:
                              (context, value, child) => Transform.translate(
                                offset: value,
                                child: Opacity(
                                  opacity: 1 - (value.dy.abs() / 80),
                                  child: child,
                                ),
                              ),
                          child: Image.asset(
                            'assets/images/seb7ax.png',
                            width: 288,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // 🔹 Continue Button
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const OnboardingPage3(),
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
