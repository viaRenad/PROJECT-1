import 'package:flutter/material.dart';

class UserHome extends StatelessWidget {
  const UserHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("مرحباً، لم تبدأ رحلة بعد"),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // TODO: Start Hajj
              },
              child: Text("ابدأ رحلة حج"),
            ),
            ElevatedButton(
              onPressed: () {
                // TODO: Start Umrah
              },
              child: Text("ابدأ رحلة عمرة"),
            ),
          ],
        ),
      ),
    );
  }
}
