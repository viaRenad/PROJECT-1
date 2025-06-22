import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mulabbi/controllers/track_controller.dart';
import 'package:mulabbi/widgets/track_widgets/track.dart';
import 'package:mulabbi/widgets/track_widgets/track_card.dart';

class IfradView extends StatelessWidget {
  const IfradView({super.key});

  @override
  Widget build(BuildContext context) {
    return Track(
      type: "ifrad",
      height: 1100,
      nuskTitle: "رحلتك في حج الإفراد",
      tracks: [
        Positioned(
          child: Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Image.asset("assets/images/track-start-right.png"),
          ),
        ),
        Positioned(
          top: 299,
          left: 97,
          child: Image.asset("assets/images/track-start-left.png"),
        ),
        Positioned(
          top: 607,
          left: 331,
          child: Container(
            transform: Matrix4.rotationY(3.14),
            child: Image.asset("assets/images/track-start-left.png"),
          ),
        ),
      ],
      trackCards: GetX<TrackController>(
        builder: (controller) {
          return Stack(
            alignment: Alignment.center,
            children: [
              TrackCard(
                left: 120,
                top: 5,
                child: TrackCardUI(
                  title: "الإحرام",
                  trackNumber: 1,
                  isCompleted: true,
                ),
              ),
              // ),
              TrackCard(
                right: -30,
                top: 60,
                child: TrackCardUI(
                  title: "طواف القدوم",
                  isLeft: false,
                  trackNumber: 2,
                  isCompleted: controller.currentStep > 1,
                  imgPath: "assets/images/step-2-kabah.png",
                ),
              ),
              TrackCard(
                left: 25,
                top: 160,
                child: TrackCardUI(
                  title: "السعي بين الصفا و المروة",
                  trackNumber: 3,
                  isCompleted: controller.currentStep > 2,
                  imgPath: "assets/images/step-3.png",
                ),
              ),
              TrackCard(
                right: -30,
                top: 260,
                child: TrackCardUI(
                  isLeft: false,
                  title: "المبيت في منى",
                  trackNumber: 4,
                  isCompleted: controller.currentStep > 3,
                  imgPath: "assets/images/step-4.png",
                ),
              ),
              TrackCard(
                left: 40,
                top: 360,
                child: TrackCardUI(
                  title: "الوقوف بعرفة",
                  trackNumber: 5,
                  isCompleted: controller.currentStep > 4,
                  imgPath: "assets/images/step-5.png",
                ),
              ),
              TrackCard(
                right: -45,
                top: 465,
                child: TrackCardUI(
                  isLeft: false,
                  title: "المبيت في مزدلفة",
                  trackNumber: 6,
                  isCompleted: controller.currentStep > 5,
                  imgPath: "assets/images/step-6.png",
                ),
              ),
              TrackCard(
                left: 40,
                top: 570,
                child: TrackCardUI(
                  title: "رمي الجمرة الأولى",
                  trackNumber: 7,
                  isCompleted: controller.currentStep > 6,
                  imgPath: "assets/images/step-7.png",
                ),
              ),
              TrackCard(
                right: -48,
                top: 673,
                child: TrackCardUI(
                  isLeft: false,
                  title: "الحلق أو التقصير",
                  trackNumber: 8,
                  isCompleted: controller.currentStep > 7,
                  imgPath: "assets/images/step-8.png",
                ),
              ),
              TrackCard(
                left: 43,
                top: 775,
                child: TrackCardUI(
                  title: "طواف الإفاضة",
                  trackNumber: 9,
                  isCompleted: controller.currentStep > 8,
                  imgPath: "assets/images/step-2-kabah.png",
                ),
              ),
              TrackCard(
                right: -45,
                top: 870,
                child: TrackCardUI(
                  isLeft: false,
                  title: "رمي الجمرات",
                  trackNumber: 10,
                  isCompleted: controller.currentStep > 9,
                  imgPath: "assets/images/step-10.png",
                ),
              ),
              TrackCard(
                left: 100,
                top: 925,
                child: TrackCardUI(
                  title: "طواف الوداع",
                  trackNumber: 11,
                  isCompleted: controller.currentStep > 10,
                  imgPath: "assets/images/step-2-kabah.png",
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
