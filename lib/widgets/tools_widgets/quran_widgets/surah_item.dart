import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mulabbi/controllers/quran_controller.dart';
import 'package:mulabbi/core/colors.dart';

class SurahItem extends StatelessWidget {
  final String title;
  final int page;
  final int surah;
  final bool selected;

  const SurahItem({
    super.key,
    required this.title,
    required this.page,
    required this.surah,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<QuranController>();

    return Container(
      margin: const EdgeInsets.only(bottom: 12.5),
      decoration: BoxDecoration(
        gradient: selected ? AppColorBrown.SelectedSurah : null,
        color: selected ? null : AppColorLight.quranNotSelected.colors[0],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColorBrown.quran.colors[0]),
        boxShadow: [
          BoxShadow(
            blurRadius: 4.0,
            offset: Offset(0, 2),
            color: const Color.fromARGB(80, 0, 0, 0),
          ),
        ],
      ),
      child: ListTile(
        title:
            selected
                ? ShaderMask(
                  shaderCallback: (bounds) {
                    return AppColorLight.linearText.createShader(
                      Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                    );
                  },
                  blendMode: BlendMode.srcIn,
                  child: Text(
                    'صفحة ($page)',
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )
                : Text(
                  'صفحة ($page)',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.brown.shade900,
                  ),
                ),
        trailing:
            selected
                ? ShaderMask(
                  shaderCallback: (bounds) {
                    return AppColorLight.linearText.createShader(
                      Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                    );
                  },
                  blendMode: BlendMode.srcIn,
                  child: Text(
                    'سورة $title',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )
                : Text(
                  'سورة $title',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.brown,
                  ),
                ),
        onTap: () {
          controller.setPage(page);
          controller.setSurah(surah + 1);
          Navigator.pop(context);
        },
      ),
    );
  }
}
