import 'package:flutter/material.dart';

class HaramCard extends StatelessWidget {
  final String title;
  final String imagePath;
  final VoidCallback onTap;
  final String videoId;

  const HaramCard({
    super.key,
    required this.title,
    required this.imagePath,
    required this.onTap,
    required this.videoId,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Container(
                width: 357,
                height: 244,
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFF734218), width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 4,
                      offset: Offset(4, 4),
                    ),
                  ],
                  shape: BoxShape.rectangle,
                ),
                child: Image.asset(
                  imagePath,
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          // بث مباشر
          Positioned(
            top: 26,
            left: 35,
            child: Container(
              width: 50,
              height: 21,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text(
                'بث مباشر',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 8,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Cairo',
                ),
              ),
            ),
          ),

          Positioned(
            bottom: 1,
            right: 10,
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                Image.asset(
                  'assets/Vector.png',
                  width: 263,
                  height: 244,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 30, right: 20),
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Cairo',
                      shadows: [
                        Shadow(
                          blurRadius: 4,
                          color: Colors.black26,
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // زاوية منحنية فيها اسم المسجد
          //Positioned(
          //  width: 263,
          //  height: 244,
          //  bottom: 0,
          //  right: 0,
          //child: ClipPath(
          //  clipper: BottomCurveClipper(),
          //  child: Container(
          //    width: 357,
          //    height: 244,
          //    decoration: BoxDecoration(gradient: AppColorBrown.gradient),
          //    alignment: Alignment.bottomRight,
          //    child: Padding(
          //      padding: const EdgeInsets.all(24.0),
          //       Text(
          //        title,
          //        style: const TextStyle(
          //          color: Colors.white,
          //          fontSize: 24,
          //          fontWeight: FontWeight.bold,
          //          fontFamily: 'ArabicFont',
          //          shadows: [
          //            Shadow(
          //              blurRadius: 4,
          //              color: Colors.black26,
          //              offset: Offset(2, 2),
          //            ),
          //          ],
          //        ),
          //      ),
          // ),
          // ),
          // ),
          //),
        ],
      ),
    );
  }
}

//class BottomCurveClipper extends CustomClipper<Path> {
//  @override
//  Path getClip(Size size) {
//    final path = Path();
//    path.moveTo(size.width, size.height - 200); // Top right
//    path.lineTo(size.width - 200, size.height); // Bottom left
//    path.lineTo(size.width, size.height); // Bottom right
//    path.close();
//   return path;
//  }

//  @override
//  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
//}
