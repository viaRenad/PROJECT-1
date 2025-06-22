import 'package:flutter/material.dart';
import 'package:quran/quran.dart' as quran;

class QuranPageContent extends StatelessWidget {
  const QuranPageContent({super.key, required this.page});
  final int page;

  @override
  Widget build(BuildContext context) {
    List<InlineSpan> verseSpans = [];

    // Loop through all surahs to find which ones are on this page
    for (int surah = 1; surah <= 114; surah++) {
      if (!quran.getSurahPages(surah).contains(page)) continue;

      int totalVerses = quran.getVerseCount(surah);

      for (int verse = 1; verse <= totalVerses; verse++) {
        if (quran.getPageNumber(surah, verse) != page) continue;

        String verseText = quran.getVerse(surah, verse);

        // Add the verse text
        verseSpans.add(
          TextSpan(
            text: '$verseText ',
            style: const TextStyle(
              fontFamily: 'KFGQPC-HafsEx1',
              fontSize: 27,
              color: Color(0xFF614832),
              height: 2.2,
            ),
          ),
        );

        // Add a small space before the verse number
        verseSpans.add(const WidgetSpan(child: SizedBox(width: 8)));

        // Add the decorative verse number from AyatQuran2
        verseSpans.add(
          TextSpan(
            text: verse.toString(),
            style: const TextStyle(
              fontFamily: 'AyatQuran2',
              fontSize: 43,
              color: Color(0xFF522600),
            ),
          ),
        );

        // Add a small space after the verse number before the next verse starts
        verseSpans.add(const WidgetSpan(child: SizedBox(width: 2)));
      }
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      child: RichText(
        textAlign: TextAlign.center,
        textDirection: TextDirection.rtl,
        text: TextSpan(children: verseSpans),
      ),
    );
  }
}
