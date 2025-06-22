import 'package:flutter/material.dart';
import 'package:mulabbi/core/colors.dart';
import 'package:mulabbi/controllers/user_profile_controller.dart';
import 'package:mulabbi/widgets/settings_widgets/custom_text_field.dart';
import 'package:mulabbi/widgets/settings_widgets/password_field.dart';
import 'package:provider/provider.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  late UserProfileController _controller;

  @override
  void initState() {
    super.initState();
    _controller = UserProfileController();
    // Load user data when entering the page
    _controller.loadUserData();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _controller,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: const Color(0xFFF5F2EE),
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            title: const Text(
              'تعديل الملف الشخصي',
              style: TextStyle(
                fontFamily: 'Cairo',
                color: Color(0xFF734218),
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            actions: [
              IconButton(
                icon: Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.rotationY(3.1416),
                  child: const Icon(
                    Icons.arrow_back_ios_new,
                    color: Color(0xFF734218),
                  ),
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          body: Consumer<UserProfileController>(
            builder: (context, controller, child) {
              if (controller.isLoading) {
                return const Center(
                  child: CircularProgressIndicator(color: Color(0xFF734218)),
                );
              }

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),

                    // Error message if any
                    if (controller.errorMessage != null)
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: Colors.red.shade50,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.red.shade200),
                        ),
                        child: Text(
                          controller.errorMessage!,
                          style: TextStyle(
                            color: Colors.red.shade700,
                            fontFamily: 'Cairo',
                          ),
                        ),
                      ),

                    const Text(
                      'الاسم بالكامل',
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    CustomTextField(
                      hint: 'ادخل اسمك الكامل...',
                      controller: controller.nameController,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'البريد الإلكتروني',
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    CustomTextField(
                      hint: 'ادخل برديك الالكتروني...',
                      controller: controller.emailController,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'كلمة المرور الجديدة (اختياري)',
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    PasswordField(controller: controller.passwordController),
                    const SizedBox(height: 40),
                    SaveChangesButton(controller: controller),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class SaveChangesButton extends StatelessWidget {
  final UserProfileController controller;

  const SaveChangesButton({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProfileController>(
      builder: (context, controller, child) {
        return Container(
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
            gradient: AppColorBrown.unlocked,
            borderRadius: BorderRadius.circular(30),
          ),
          child: ElevatedButton(
            onPressed:
                controller.isLoading
                    ? null
                    : () async {
                      final success = await controller.saveUserProfile();
                      if (success && context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'تم حفظ التغييرات بنجاح',
                              style: TextStyle(fontFamily: 'Cairo'),
                            ),
                            backgroundColor: Colors.green,
                          ),
                        );
                        Navigator.pop(context);
                      } else if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              controller.errorMessage ?? 'حدث خطأ أثناء الحفظ',
                              style: const TextStyle(fontFamily: 'Cairo'),
                            ),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child:
                controller.isLoading
                    ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                    : const Text(
                      'حفظ التغييرات',
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
          ),
        );
      },
    );
  }
}
