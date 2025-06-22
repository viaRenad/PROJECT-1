import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mulabbi/controllers/track_controller.dart';
import 'package:mulabbi/widgets/track_widgets/track.dart';
import 'package:mulabbi/widgets/track_widgets/track_card.dart';

class QeranView extends StatelessWidget {
  const QeranView({super.key});

  @override
  Widget build(BuildContext context) {
    return Track(
      type: "qeran",
      height: 1160,
      nuskTitle: "رحلتك في حج القران",
      tracks: [
        Positioned(
          child: Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Image.asset("assets/images/track-start-right.png"),
          ),
        ),
        Positioned(
          top: 299,
          left: 95,
          child: Image.asset("assets/images/track-start-left.png"),
        ),
        Positioned(
          top: 608,
          left: 328,
          child: Container(
            transform: Matrix4.rotationY(3.14),
            child: Image.asset("assets/images/track-start-left.png"),
          ),
        ),
        Positioned(
          top: 913,
          left: 240,
          child: Container(
            transform: Matrix4.rotationY(3.14),
            child: Image.asset("assets/images/track-remain.png"),
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
                  title: "الإحرام للحج",
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
                left: 35,
                top: 360,
                child: TrackCardUI(
                  title: "الوقوف بعرفة",
                  trackNumber: 5,
                  isCompleted: controller.currentStep > 4,
                  imgPath: "assets/images/step-5.png",
                ),
              ),
              TrackCard(
                right: -43,
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
                right: -45,
                top: 670,
                child: TrackCardUI(
                  isLeft: false,
                  title: "ذبح الهدي",
                  trackNumber: 8,
                  isCompleted: controller.currentStep > 7,
                  imgPath: "assets/images/step-qeran.png",
                ),
              ),
              TrackCard(
                left: 40,
                top: 775,
                child: TrackCardUI(
                  title: "الحلق أو التقصير",
                  trackNumber: 9,
                  isCompleted: controller.currentStep > 8,
                  imgPath: "assets/images/step-8.png",
                ),
              ),
              TrackCard(
                right: -43,
                top: 878,

                child: TrackCardUI(
                  isLeft: false,
                  title: "طواف الإفاضة",
                  trackNumber: 10,
                  isCompleted: controller.currentStep > 9,
                  imgPath: "assets/images/step-2-kabah.png",
                ),
              ),
              TrackCard(
                left: 35,
                top: 980,
                child: TrackCardUI(
                  title: "رمي الجمرات",
                  trackNumber: 11,
                  isCompleted: controller.currentStep > 10,
                  imgPath: "assets/images/step-10.png",
                ),
              ),
              TrackCard(
                left: 195,
                top: 1025,
                child: TrackCardUI(
                  isLeft: false,
                  title: "طواف الوداع",
                  trackNumber: 12,
                  isCompleted: controller.currentStep > 11,
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
