import 'package:flutter/material.dart';
import 'package:mulabbi/core/colors.dart';
import 'package:mulabbi/main.dart';
import 'package:mulabbi/services/user_service.dart';
import 'package:mulabbi/views/Introductory_screens/onboarding/onboarding_page1.dart';
import 'package:mulabbi/views/Introductory_screens/welcome_screen.dart';
import 'package:mulabbi/views/shell/main_scaffold.dart';

class IsNewUserScreen extends StatefulWidget {
  const IsNewUserScreen({super.key});

  @override
  State<IsNewUserScreen> createState() => _IsNewUserScreenState();
}

class _IsNewUserScreenState extends State<IsNewUserScreen> {
  getFirstTime<bool>() async {
    return await storage.getBool("isFirstTime");
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: UserService.getCurrentUser(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                backgroundColor: AppColorBrown.gradientColors.first,
                color: AppColorBrown.angularGoldColors.first,
              ),
            ),
          );
        }

        return !snapshot.hasData
            ? FutureBuilder(
              future: getFirstTime(),
              builder: (context, snapshot) {
                if (snapshot.data == false) {
                  return WelcomeScreen();
                }

                return OnboardingPage1();
              },
            )
            : MainScaffold(userType: UserType.user);
      },
    );
  }
}
