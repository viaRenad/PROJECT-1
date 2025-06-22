import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mulabbi/core/colors.dart';
import 'package:mulabbi/main.dart';
import 'package:mulabbi/views/auth/singup_page.dart';
import 'package:mulabbi/views/shell/main_scaffold.dart';
// import 'package:mulabbi/views/shell/main_scaffold.dart';
import 'package:mulabbi/widgets/auth_widgets/auth_custom.dart';
import 'package:mulabbi/widgets/tools_widgets/button_custom.dart';
import 'package:mulabbi/widgets/auth_widgets/social_widget.dart';
import 'package:mulabbi/widgets/auth_widgets/textfield_custom.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const buttonColor = AppColorBrown.gradient;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _rememberMe = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  // bool _isLoading = false;

  // Future<void> _signIn() async {
  //   setState(() {
  //     _isLoading = true;
  //   });

  //   try {
  //     await Supabase.instance.client.auth.signInWithPassword(
  //       email: emailController.text,
  //       password: passwordController.text,
  //     );
  //   } on AuthException catch (error) {
  //     if (mounted) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('خطأ في تسجيل الدخول: ${error.message}')),
  //       );
  //     }
  //   } catch (error) {
  //     if (mounted) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('حدث خطأ غير متوقع: $error')),
  //       );
  //     }
  //   } finally {
  //     if (mounted) {
  //       setState(() {
  //         _isLoading = false;
  //       });
  //     }
  //   }
  // }

  // Future<void> _signUp() async {
  //   setState(() {
  //     _isLoading = true;
  //   });

  //   try {
  //     await Supabase.instance.client.auth.signUp(
  //       email: emailController.text,
  //       password: passwordController.text,
  //     );

  //     if (mounted) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(content: Text('تم إنشاء الحساب بنجاح!')),
  //       );
  //     }
  //   } on AuthException catch (error) {
  //     if (mounted) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('خطأ في إنشاء الحساب: ${error.message}')),
  //       );
  //     }
  //   } catch (error) {
  //     if (mounted) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('حدث خطأ غير متوقع: $error')),
  //       );
  //     }
  //   } finally {
  //     if (mounted) {
  //       setState(() {
  //         _isLoading = false;
  //       });
  //     }
  //   }
  // }

  // Future<void> _continueAsGuest() async {
  //   // الانتقال للصفحة الرئيسية كزائر
  //   Navigator.of(context).pushReplacement(
  //     MaterialPageRoute(builder: (_) => const MainScaffold()),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return AuthContainer(
      title: "تسجيل الدخول",
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const SizedBox(height: 12),
              CustomTextField(
                label: "*البريد الإلكتروني",
                hint: "أدخل بريدك الإلكتروني",
                keyboardType: TextInputType.emailAddress,
                controller: emailController,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: "*كلمة المرور",
                hint: "ادخل كلمة المرور",
                obscureText: true,
                controller: passwordController,
              ),
              const SizedBox(height: 1),
              Row(
                children: [
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      "نسيت كلمة المرور؟",
                      style: TextStyle(
                        color: Color(0xFF69494B),
                        decoration: TextDecoration.underline,
                        decorationColor: Color(0xFF69494B),
                      ),
                    ),
                  ),
                  const Spacer(),
                  const Text(
                    'تذكرني',
                    style: TextStyle(color: Color(0xFF734218)),
                  ),
                  Checkbox(
                    value: _rememberMe,
                    onChanged: (bool? value) {
                      setState(() {
                        _rememberMe = value ?? false;
                      });
                    },
                    hoverColor: Color(0xFF734218),
                    checkColor: Colors.white,
                    activeColor: const Color(0xFF734218),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Center(
                child: SizedBox(
                  width: 200,
                  height: 50,
                  child: PrimaryButton(
                    text: "تسجيل",
                    color: const Color(0xFF5D4037),
                    onPressed: () async {
                      final AuthResponse response = await supabase.auth
                          .signInWithPassword(
                            email: emailController.text,
                            password: passwordController.text,
                          );
                      await storage.setString(
                        'token',
                        response.session!.accessToken,
                      );

                      Get.to(() => MainScaffold(userType: UserType.user));
                    },
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SingupPage(),
                        ),
                      );
                    },
                    child: const Text(
                      "إنشاء حساب",
                      style: TextStyle(
                        color: Color(0xFF8D511E),
                        decoration: TextDecoration.underline,
                        decorationColor: Color(0xFF8D511E),
                      ),
                    ),
                  ),
                  Text('لا تمتلك حساب؟', style: TextStyle(color: Colors.grey)),
                ],
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Text(
                    '________أو_________',
                    style: TextStyle(color: Color(0xFF7E5A3B)),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SocialIconButton(
                    onTap: () {},
                    imagePath: 'assets/images/google.svg',
                  ),
                  const SizedBox(width: 24),
                  SocialIconButton(
                    onTap: () {},
                    imagePath: 'assets/images/facebook.svg',
                  ),
                  const SizedBox(width: 24),
                  SocialIconButton(
                    onTap: () {},
                    imagePath: 'assets/images/apple.svg',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
