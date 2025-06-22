import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mulabbi/controllers/adhkar_controller.dart';
import 'package:mulabbi/widgets/tools_widgets/azkar_widgets/adkkar_title_card.dart';

class AdhkarView extends StatelessWidget {
  final AdhkarController controller;

  AdhkarView({super.key}) : controller = Get.put(AdhkarController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 230, 220, 207),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: Color(0xFF7E5A3B)),
          onPressed: () {
            Navigator.pop(context); // or Get.back();
          },
        ),
        title: const Text(
          'الاذكار',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: Color(0xFF7E5A3B),
            fontFamily: 'AlNile', // ← matching what you wrote in pubspec
            height: 1.0,
          ),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
      ),

      body: SafeArea(
        child: Obx(() {
          final data = controller.allDuas;

          return ListView(
            padding: EdgeInsets.all(16),
            children:
                data.entries.map((entry) {
                  return Column(
                    children: [
                      TitleCard(
                        title: entry.key,
                        isExpanded: entry.key == '',
                        adhkar: entry.value,
                      ),
                      SizedBox(height: 12),
                    ],
                  );
                }).toList(),
          );
        }),
      ),
    );
  }
}
