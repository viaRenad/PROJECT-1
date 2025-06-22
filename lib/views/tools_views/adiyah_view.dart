import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mulabbi/controllers/dua_controller.dart';
import 'package:mulabbi/widgets/tools_widgets/dua_widgets/dua_title_card.dart';

class DuasPage extends StatelessWidget {
  const DuasPage({super.key});

  @override
  Widget build(BuildContext context) {
    final DuasController controller = Get.put(DuasController());
    return Scaffold(
      backgroundColor: Color(0xFFF5F2EE),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Color(0xFF7E5A3B),
            size: 22, // slightly smaller like the screenshot
          ),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onPressed: () {
            Navigator.pop(context); // make sure it actually goes back
          },
        ),
        title: const Text(
          'أدعية',
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
                        isExpanded: entry.key == 'أدعية الحج', // مثال فقط
                        duas: entry.value,
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
