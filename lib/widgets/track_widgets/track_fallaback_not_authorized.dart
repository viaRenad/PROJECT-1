import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mulabbi/core/colors.dart';
import 'package:mulabbi/views/auth/login_page.dart';
import 'package:mulabbi/views/auth/singup_page.dart';

class TrackFallbackNotAuthorized extends StatelessWidget {
  const TrackFallbackNotAuthorized({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(
          "assets/images/track_page.png",
          fit: BoxFit.cover,
          width: 800,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ShaderMask(
              shaderCallback:
                  (bounds) =>
                      AppColorBrown.gradientPrimary.createShader(bounds),
              child: Text(
                "تحتاج الى تسجيل الدخول",
                textDirection: TextDirection.rtl,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "سجل دخولك لمتابعة مناسكك\nخطوة بخطوة عند بدء رحلتك",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 17, color: Colors.black87),
            ),
            const SizedBox(height: 15),
            InkWell(
              onTap: () {
                Get.to(() => LoginScreen());
              },
              child: Container(
                width: 246,
                height: 58,
                decoration: BoxDecoration(
                  gradient: AppColorBrown.gradientBrown,
                  borderRadius: BorderRadius.circular(66),
                ),
                child: Center(
                  child: Text(
                    "تسجيل الدخول",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          offset: Offset(2, 2),
                          blurRadius: 4,
                          color: Colors.black45,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            InkWell(
              onTap: () {
                Get.to(() => SingupPage());
              },
              child: const Text(
                "إنشاء حساب جديد",
                style: TextStyle(
                  color: Color(0xFF734218),
                  decoration: TextDecoration.underline,
                  decorationColor: Color(0xFF734218),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
