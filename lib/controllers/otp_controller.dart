import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mulabbi/views/auth/login_page.dart';
import 'package:mulabbi/widgets/tools_widgets/button_custom.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class OtpController extends GetxController {
  final SupabaseClient supabase = Supabase.instance.client;

  // خانات الإدخال
  List<TextEditingController> codeControllers = List.generate(
    6,
    (_) => TextEditingController(),
  );

  // إعادة الإرسال
  var secondsRemaining = 60.obs;
  var canResend = false.obs;
  Timer? _timer;

  void startTimer() {
    secondsRemaining.value = 60;
    canResend.value = false;

    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (secondsRemaining.value == 0) {
        canResend.value = true;
        timer.cancel();
      } else {
        secondsRemaining.value--;
      }
    });
  }

  Future<void> resendOtp(String email) async {
    try {
      await supabase.auth.resend(type: OtpType.signup, email: email);
      Get.snackbar("تم الإرسال", "تم إرسال رمز تحقق جديد إلى بريدك");
      startTimer();
    } catch (e) {
      Get.snackbar("خطأ", "تعذر إعادة إرسال الرمز");
    }
  }

  Future<void> verifyOtp(String email) async {
    final code = codeControllers.map((c) => c.text).join();

    if (code.length != 6) {
      Get.snackbar("خطأ", "أدخل رمز مكون من 6 أرقام");
      return;
    }

    try {
      await supabase.auth.verifyOTP(
        type: OtpType.signup,
        token: code,
        email: email,
      );
      _showSuccessDialog(Get.context!);
    } catch (e) {
      Get.snackbar("فشل", "رمز التحقق غير صحيح أو منتهي");
    }
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}

void _showSuccessDialog(BuildContext context) {
  //i prefer this if you want to control the position
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: "CustomDialog",
    pageBuilder: (context, animation, secondaryAnimation) {
      return Stack(
        children: [
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2), // درجة التغبيش
            child: Container(
              color: Color(
                0xFFE5D4B8,
              ).withOpacity(0.3), // تغطية خفيفة فوق التغبيش
            ),
          ),

          Positioned(
            top: 290,
            left: 20,
            right: 20,
            child: Material(
              color: Colors.transparent,
              child: Dialog(
                shadowColor: Color.fromARGB(182, 93, 43, 0),
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(27),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(47),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.verified,
                        size: 80,
                        color: Color.fromARGB(255, 115, 83, 45),
                        shadows: [
                          Shadow(
                            color: Color.fromARGB(42, 0, 0, 0),
                            offset: Offset(0, 4),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        "تم تأكيد حسابك بنجاح",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Cairo',
                        ),
                      ),
                      const SizedBox(height: 100),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: SizedBox(
                          width: 184,
                          height: 51,
                          child: PrimaryButton(
                            text: "تسجيل الدخول",
                            color: const Color(0xFF5D4037),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginScreen(),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    },
  );
}
