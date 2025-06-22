import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mulabbi/core/colors.dart';

class MisbahaView extends StatefulWidget {
  const MisbahaView({super.key});

  static const fontColor = AppColorBrown.gradientPrimary;
  static const background = AppColorLight.linear;

  @override
  _MisbahaViewState createState() => _MisbahaViewState();
}

class _MisbahaViewState extends State<MisbahaView> {
  int counter = 0;
  final int beadsCount = 33;

  @override
  void initState() {
    super.initState();
    _loadCounter(); // Load saved count
  }

  Future<void> _loadCounter() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      counter = prefs.getInt('tasbihCount') ?? 0;
    });
  }

  Future<void> _saveCounter() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('tasbihCount', counter);
  }

  Future<void> _resetCounter() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('tasbihCount', 0);
    setState(() {
      counter = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Color(0xFF7E5A3B)),
        actions: [
          TextButton(
            onPressed: _resetCounter,
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text(
                  'إعادة',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF7E5A3B),
                    fontFamily: 'Cairo',
                  ),
                ),
                SizedBox(width: 6), // spacing between text and icon
                Icon(Icons.restart_alt, color: Color(0xFF7E5A3B), size: 28),
              ],
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/misbaha_page.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFFF5F2EE).withOpacity(0.8),
                    Color.fromARGB(255, 233, 221, 206).withOpacity(1.0),
                  ],
                ),
              ),
            ),
          ),
          SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 30),
                  const SizedBox(
                    width: 312,
                    height: 83,
                    child: Text(
                      'سَبِّحِ ٱسْمَ رَبِّكَ ٱلْأَعْلَى',
                      style: TextStyle(
                        fontSize: 38,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF874F1E),
                        fontFamily: 'KFGQPC-HafsEx1',
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          counter++;
                        });
                        _saveCounter();
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Image.asset(
                            'assets/images/Sebha.png',
                            width: 370,
                            height: 450,
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(height: 75),
                              ShaderMask(
                                shaderCallback:
                                    (bounds) =>
                                        AppColorBrown.unlocked.createShader(
                                          Rect.fromLTWH(
                                            0,
                                            0,
                                            bounds.width,
                                            bounds.height,
                                          ),
                                        ),
                                child: const Text(
                                  'سبحان الله',
                                  style: TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Cairo',
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              const SizedBox(height: 10),
                              ShaderMask(
                                shaderCallback:
                                    (bounds) =>
                                        AppColorBrown.unlocked.createShader(
                                          Rect.fromLTWH(
                                            0,
                                            0,
                                            bounds.width,
                                            bounds.height,
                                          ),
                                        ),
                                child: Text(
                                  '$counter',
                                  style: const TextStyle(
                                    fontSize: 60,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Cairo',
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
