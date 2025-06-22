import 'package:flutter/material.dart';

class AppColorBrown {
  static const List<Color> gradientColors = [
    Color(0xFFA3704B),
    Color.fromARGB(204, 237, 172, 125), // 0xCC = 80% opacity
    Color.fromARGB(235, 115, 66, 24),
  ];
  static const LinearGradient gradient = LinearGradient(
    colors: gradientColors,
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  // Angular gradient (design reference only — not directly supported by Flutter natively)
  static const List<Color> angularGoldColors = [
    Color(0xFFD9A96B), // 50%
    Color(0xFFEAB872), // 100%
  ];

  static const List<double> angularGoldStops = [0.5, 1.0];

  static const LinearGradient brownArticleOverlay = LinearGradient(
    colors: [
      Color.fromRGBO(136, 83, 37, 0.08), // #885325 with 60% opacity
      Color.fromRGBO(194, 194, 194, 0.08),
    ],
    begin: Alignment.centerRight,
    end: Alignment.centerLeft,
  );

  static const LinearGradient gradientBrown = LinearGradient(
    colors: [Color(0xFFA3704B), Color(0xFFAE7D56), Color(0xFF734218)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const LinearGradient SelectedSurah = LinearGradient(
    colors: [
      Color(0xFF7E573B), // 0% stop
      Color(0xFFA27655), // 48% stop
      Color(0xFFBD8D6A), // 100% stop
    ],
    begin: Alignment.centerRight,
    end: Alignment.centerLeft,
  );

  static const LinearGradient diagonal = LinearGradient(
    colors: [
      Color(0xFF9D5B2B),
      Color(0xFFC9946D),
      Color(0xFFB4825D),
      Color(0xFFA3704B),
    ],
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
  );

  static const LinearGradient gradientPrimary = LinearGradient(
    colors: [
      Color(0xFF734218),
      Color.fromARGB(255, 152, 110, 78),
      Color(0xFF734218),
    ],
    stops: [0.0, 0.5, 1.0],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const LinearGradient carfBrown = LinearGradient(
    colors: [Color(0xFF7E573B), Color(0xFFA27655), Color(0xFFA78166)],
    begin: Alignment.bottomRight,
    end: Alignment.topLeft,
  );

  static const LinearGradient quran = LinearGradient(
    colors: [Color(0xFF7E573B), Color(0xFFA27655), Color(0xFFBD8D6A)],
    begin: Alignment.centerRight,
    end: Alignment.centerLeft,
  );

  static const LinearGradient bottomNav = LinearGradient(
    colors: [Color(0xFF7E573B), Color(0xFFA27655), Color(0xFFA78166)],
    begin: Alignment.centerRight,
    end: Alignment.centerLeft,
  );

  static const LinearGradient hajj = LinearGradient(
    colors: [
      Color(0xFFBD8D6A), // 0%
      Color(0xFFA27655), // 48%
      Color(0xFF7E573B), // 100%
    ],
    stops: [0.0, 0.48, 1.0],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const LinearGradient cardFont = LinearGradient(
    colors: [Color(0xFFE4A36B), Color(0xFF7E573B)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const RadialGradient brownPearl = RadialGradient(
    colors: [
      Color(0xFFF1B578),
      Color(0xFFC88F55),
      Color(0xFFA36C35),
      Color(0xFF724D33),
    ],
    center: Alignment.center,
    radius: 0.5,
  );

  static const RadialGradient pearl = RadialGradient(
    colors: [
      Color(0xFFFFBE7C),
      Color(0xFFDB9B5B),
      Color(0xFFB6783A),
      Color(0xFF896041),
    ],
    center: Alignment.center,
    radius: 0.5,
  );

  static const RadialGradient brown = RadialGradient(
    colors: [
      Color(0xFFB4825D),
      Color(0xFFA3704B),
      Color(0xFF734218),
      Color(0xFF5A2F1A),
    ],
    center: Alignment.center,
    radius: 0.5,
  );

  static const LinearGradient xColor = LinearGradient(
    colors: [Color(0xFFA3704B), Color(0xFFAE7D56), Color(0xFF734218)],
    begin: Alignment.centerRight,
    end: Alignment.centerLeft,
  );

  static const LinearGradient unlocked = LinearGradient(
    colors: [Color(0xFF734218), Color(0xFF9A7356), Color(0xFF734218)],
    begin: Alignment.centerRight,
    end: Alignment.centerLeft,
  );
}

class AppColorLight {
  static final light = ColorLight;
  static const LinearGradient backgroundHome = LinearGradient(
    colors: [
      Color.fromARGB(253, 206, 183, 165),
      Color.fromARGB(197, 203, 159, 126),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient background = LinearGradient(
    colors: [Color(0xFFFBF8F2), Color.fromARGB(84, 224, 210, 197)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient linear = LinearGradient(
    colors: [Color(0xFFFBF8F2), Color.fromARGB(115, 224, 210, 197)],
    begin: Alignment.centerRight,
    end: Alignment.centerLeft,
  );

  static const LinearGradient linearText = LinearGradient(
    colors: [
      Color(0xFFFFFFFF),
      Color.fromARGB(255, 246, 246, 246),
      Color(0xFFEBEBEB),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient greyGradient = LinearGradient(
    colors: [Color(0xFFEAEAEA), Color(0xFFFFFFFF), Color(0xFFEDEDED)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const LinearGradient articles = LinearGradient(
    colors: [Color(0xFFEDEDED), Color(0xFFDBDBDB)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient fontLinear = LinearGradient(
    colors: [Color(0xFFFFFFFF), Color(0xFFF6F6F6), Color(0xFFEBEBEB)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const LinearGradient quranNotSelected = LinearGradient(
    colors: [Color(0xFFF1EBE2), Color(0xFFDFCCB8)],
    begin: Alignment.centerRight,
    end: Alignment.centerLeft,
  );

  static const LinearGradient fontSoftWhite = LinearGradient(
    colors: [
      Color(0xFFFFFFFF), // white
      Color(0xFFEAEAEA),
      Color(0xFFD2D2D2),
    ],
    begin: Alignment.centerRight,
    end: Alignment.centerLeft,
  );
}

//this class is implement only for the light Color in figma
class ColorLight {
  static const LinearGradient grey = LinearGradient(
    colors: [Color.fromARGB(0, 255, 255, 255), Color(0xFF818181)],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
  );

  static const LinearGradient lightYellow = LinearGradient(
    colors: [Color(0xFFF9F2E1), Color(0xFFF3EDDB)],
    begin: Alignment.centerRight,
    end: Alignment.centerLeft,
  );

  static const LinearGradient lightYellowGrey = LinearGradient(
    colors: [Color(0xFFFAF7E3), Color(0xFFF6F0DD), Color(0xFFD8CBB6)],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
  );

  static const Color lightWhite = Color(0xFFF5F2EE);
}

class AppColorGreen {
  static const LinearGradient greenish = LinearGradient(
    colors: [Color(0xFF809E94), Color(0xFF4F645D)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}

class AppColorGrey {
  static const LinearGradient lockedNumber = LinearGradient(
    colors: [Color(0xFFB4B4B4), Color(0xFF818181)],
    begin: Alignment.bottomRight,
    end: Alignment.bottomLeft,
  );

  static const LinearGradient umrah = LinearGradient(
    colors: [Color(0xFF4E4E4E), Color(0xFF838383), Color(0xFFA2A2A2)],
    begin: Alignment.centerRight,
    end: Alignment.centerLeft,
  );
}
