import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mulabbi/main.dart';
import 'package:mulabbi/views/auth/otp_cheak_page.dart';
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
  @override
  Widget build(BuildContext context) {
    return AuthContainer(
      title: "إنشاء حساب",
      child: Padding(
        padding: const EdgeInsets.only(top: 16, left: 4, right: 4, bottom: 6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const SizedBox(height: 1),
            CustomTextField(
              label: "الاسم الكامل",
              hint: "أدخل اسمك الكامل",
              controller: nameController,
            ),
            const SizedBox(height: 20),
            CustomTextField(
              label: "البريد الإلكتروني",
              hint: "أدخل بريدك الإلكتروني",
              keyboardType: TextInputType.emailAddress,
              controller: emailController,
            ),
            const SizedBox(height: 20),
            CustomTextField(
              label: "كلمة المرور",
              hint: "••••••••",
              obscureText: true,
              controller: passwordController,
            ),
            const SizedBox(height: 1),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text(
                  'عند التسجيل فإني أوافق على الشروط والأحكام',
                  style: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontSize: 12,
                    fontFamily: 'Cairo',
                  ),
                ),
                Checkbox(
                  value: _agree,
                  onChanged: (bool? value) {
                    setState(() {
                      _agree = value ?? false;
                    });
                  },
                  hoverColor: Color(0xFF734218),
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
                  color: const Color(0xFF5D4037),
                  onPressed: () // {
                  //   Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (context) => const OtpScreen(),
                  //     ),
                  //   );
                  async {
                    final res = await supabase.auth.signUp(
                      email: emailController.text,
                      password: passwordController.text,
                    );
                    // final res = await supabase.auth.signUp(
                    //  email: 'fnaralslmy38@gmail.com',
                    // password: '123456@dyhuA',
                    //  );
                    await supabase.from('users').insert({
                      'id': res.user?.id,
                      'name': nameController.text,
                      'email': emailController.text,
                    });
                    Get.offUntil(
                      MaterialPageRoute(
                        builder:
                            (context) => OtpScreen(email: emailController.text),
                      ),
                      (route) => false,
                    );
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
