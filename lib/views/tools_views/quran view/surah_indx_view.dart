import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mulabbi/controllers/quran_controller.dart';
import 'package:mulabbi/widgets/tools_widgets/quran_widgets/surah_item.dart';
import 'package:quran/quran.dart' as quran;

class SurahDrawer extends StatelessWidget {
  const SurahDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<QuranController>();
    final scrollController = ScrollController();

    // ⬇️ Jump to current Surah after build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final index = controller.getSurah() - 1;
      final estimatedOffset =
          index * 70.0; // adjust if your tiles are taller/shorter
      try {
        scrollController.jumpTo(
          estimatedOffset.clamp(0, scrollController.position.maxScrollExtent),
        );
      } catch (_) {
        // ignore errors if not yet laid out
      }
    });

    return Drawer(
      backgroundColor: const Color(0xFFF9F4EF),
      child: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'فهرس السور',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 12.5,
              ),
              child: TextField(
                onChanged: controller.updateSearch,
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.right,
                cursorColor: const Color(0xFFAE7D56),
                style: const TextStyle(
                  color: Color(0xFF7E5A3B),
                  fontWeight: FontWeight.w500,
                ),
                decoration: InputDecoration(
                  hintText: "...ابحث عن سورة",
                  hintStyle: const TextStyle(
                    color: Color.fromARGB(255, 119, 87, 63),
                    fontWeight: FontWeight.w400,
                  ),
                  alignLabelWithHint: true,
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Icon(
                      Icons.menu_book_rounded,
                      color: Color.fromARGB(255, 172, 153, 138),
                      size: 22,
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.transparent,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 12,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(
                      color: Color.fromARGB(255, 131, 103, 83),
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(
                      color: Color.fromARGB(255, 119, 87, 63),
                      width: 1,
                    ),
                  ),
                ),
              ),
            ),

            // ✅ Scrollable & reactive surah list
            Expanded(
              child: Obx(() {
                final filteredList =
                    List.generate(114, (i) => i + 1).where((i) {
                      final name = quran.getSurahNameArabic(i);
                      return name.contains(controller.searchText.value);
                    }).toList();

                return ListView.builder(
                  controller: scrollController,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: filteredList.length,
                  itemBuilder: (context, i) {
                    final surahNum = filteredList[i];
                    final isSelected = controller.getSurah() == surahNum;

                    return SurahItem(
                      title: quran.getSurahNameArabic(surahNum),
                      page: quran.getPageNumber(surahNum, 1),
                      surah: surahNum - 1,
                      selected: isSelected,
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
