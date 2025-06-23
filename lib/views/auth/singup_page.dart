import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mulabbi/core/colors.dart';
import 'package:mulabbi/main.dart';
import 'package:mulabbi/views/auth/otp_cheak_page.dart';
import 'package:mulabbi/views/auth/policy_page.dart';
import 'package:mulabbi/widgets/auth_widgets/auth_custom.dart';
import 'package:mulabbi/widgets/auth_widgets/textfield_custom.dart';
import 'package:mulabbi/widgets/tools_widgets/button_custom.dart';

class SingupPage extends StatefulWidget {
  const SingupPage({super.key});

  @override
  State<SingupPage> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<SingupPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _agree = false;
  late TapGestureRecognizer _policyRecognizer;

  @override
  void initState() {
    super.initState();
    _policyRecognizer =
        TapGestureRecognizer()
          ..onTap = () {
            Get.to(() => const PolicyPage());
          };
  }

  @override
  void dispose() {
    _policyRecognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AuthContainer(
      title: "إنشاء حساب",
      cardHeight: 520,
      cardWidth: 400,
      child: Padding(
        padding: const EdgeInsets.only(top: 16, left: 4, right: 4, bottom: 6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const SizedBox(height: 1),
            CustomTextField(
              label: "*الاسم الكامل",
              hint: "أدخل اسمك الكامل",
              controller: nameController,
            ),
            const SizedBox(height: 20),
            CustomTextField(
              label: "*البريد الإلكتروني",
              hint: "أدخل بريدك الإلكتروني",
              keyboardType: TextInputType.emailAddress,
              controller: emailController,
            ),
            const SizedBox(height: 20),
            CustomTextField(
              label: "*كلمة المرور",
              hint: "••••••••",
              obscureText: true,
              controller: passwordController,
            ),
            const SizedBox(height: 1),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                RichText(
                  text: TextSpan(
                    text: 'عند التسجيل فإني أوافق على ',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontFamily: 'Cairo',
                    ),
                    children: [
                      TextSpan(
                        text: 'الشروط والأحكام',
                        style: const TextStyle(
                          color: Color(0xFF8D511E),
                          decoration: TextDecoration.underline,
                          decorationColor: Color(0xFF8D511E),
                          fontWeight: FontWeight.w600,
                        ),
                        recognizer: _policyRecognizer,
                      ),
                    ],
                  ),
                ),
                Checkbox(
                  value: _agree,
                  onChanged: (bool? value) {
                    setState(() {
                      _agree = value ?? false;
                    });
                  },
                  hoverColor: const Color(0xFF734218),
                  checkColor: Colors.white,
                  activeColor: const Color(0xFF734218),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                  ),
                  semanticLabel: 'عند التسجيل فإني أوافق على الشروط والأحكام',
                ),
              ],
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: 184,
                height: 51,
                child: PrimaryButton(
                  text: "إنشاء حساب",
                  gradient: AppColorBrown.gradientBrown,
                  onPressed: () async {
                    try {
                      final res = await supabase.auth.signUp(
                        email: emailController.text,
                        password: passwordController.text,
                      );
                      await supabase.from('users').insert({
                        'id': res.user?.id,
                        'name': nameController.text,
                        'email': emailController.text,
                      });
                      Get.offUntil(
                        MaterialPageRoute(
                          builder:
                              (context) =>
                                  OtpScreen(email: emailController.text),
                        ),
                        (route) => false,
                      );
                      // ignore: empty_catches
                    } catch (e) {
                      print(e);
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
