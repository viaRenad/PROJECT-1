import 'package:flutter/material.dart';
import 'package:mulabbi/core/colors.dart';
import 'package:mulabbi/views/settings_views/user_profile.dart';
import 'package:mulabbi/widgets/settings_widgets/language_row.dart';
import 'package:mulabbi/widgets/settings_widgets/settings_row.dart';
import 'package:mulabbi/widgets/settings_widgets/toggle_row.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:mulabbi/views/settings_views/faq_page.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool notificationsEnabled = true;
  String selectedLanguage = 'ar'; // 'ar' for Arabic, 'en' for English
  Map<String, dynamic>? userData;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    final user = Supabase.instance.client.auth.currentUser;

    if (user != null) {
      final response =
          await Supabase.instance.client
              .from('users')
              .select()
              .eq('id', user.id)
              .single();

      if (mounted) {
        setState(() {
          userData = response;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFF9F7F4),
        body: Column(
          children: [
            Stack(
              children: [
                ClipPath(
                  clipper: ArcClipper(),
                  child: Container(height: 345, color: const Color(0xFFE0D1B5)),
                ),
                ClipPath(
                  clipper: ArcClipper(),
                  child: Container(
                    height: 320,
                    decoration: const BoxDecoration(
                      gradient: AppColorBrown.diagonal,
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 166),
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          const CircleAvatar(
                            radius: 65,
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.person,
                              size: 90,
                              color: Color(0xFFA57859),
                            ),
                          ),
                          Positioned(
                            bottom: 4,
                            right: 4,
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: const BoxDecoration(
                                color: Color(0xFF9E7354),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.camera_alt_rounded,
                                size: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            Container(
              width: 360,
              padding: const EdgeInsets.symmetric(vertical: 26, horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(40),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.12),
                    blurRadius: 8,
                    offset: const Offset(2, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  SettingsRow(
                    title: 'تعديل الملف الشخصي',
                    icon: Icons.person,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const UserProfile(),
                        ),
                      );
                    },
                  ),
                  const Divider(thickness: 1, color: Color(0xFFEDEDED)),
                  ToggleRow(
                    title: 'الإشعارات',
                    icon: Icons.notifications_outlined,
                    value: notificationsEnabled,
                    onChanged: (bool value) {
                      setState(() {
                        notificationsEnabled = value;
                      });
                    },
                  ),
                  const Divider(thickness: 1, color: Color(0xFFEDEDED)),
                  LanguageRow(
                    selectedLanguage: selectedLanguage,
                    onLanguageChanged: (lang) {
                      setState(() {
                        selectedLanguage = lang;
                      });
                    },
                  ),
                  const Divider(thickness: 1, color: Color(0xFFEDEDED)),
                  SettingsRow(
                    title: 'الأسئلة الشائعة & الدعم',
                    icon: Icons.help_outline,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const FaqPage(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ArcClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    final double height = size.height;
    final double width = size.width;

    path.lineTo(0, height - 110);
    path.quadraticBezierTo(width / 2, height + 50, width, height - 110);
    path.lineTo(width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
