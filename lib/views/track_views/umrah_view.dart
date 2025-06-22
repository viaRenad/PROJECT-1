import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mulabbi/controllers/track_controller.dart';
import 'package:mulabbi/widgets/track_widgets/track.dart';
import 'package:mulabbi/widgets/track_widgets/track_card.dart';

class UmrahView extends StatelessWidget {
  const UmrahView({super.key});

  @override
  Widget build(BuildContext context) {
    return Track(
      type: "umrah",
      height: 400,
      nuskTitle: "رحلتك في العمرة",
      tracks: [Positioned(child: Image.asset("assets/images/track-umrah.png"))],
      trackCards: GetX<TrackController>(
        builder: (controller) {
          return Stack(
            alignment: Alignment.center,
            children: [
              TrackCard(
                left: 120,
                top: 15,
                child: TrackCardUI(
                  title: "الإحرام للعمرة",
                  trackNumber: 1,
                  isCompleted: true,
                ),
              ),
              // ),
              TrackCard(
                right: -30,
                top: 65,
                child: TrackCardUI(
                  title: "طواف العمرة",
                  isLeft: false,
                  trackNumber: 2,
                  isCompleted: controller.currentStep > 1,
                  imgPath: "assets/images/step-2-kabah.png",
                ),
              ),
              TrackCard(
                left: 23,
                top: 170,
                child: TrackCardUI(
                  title: "السعي بين الصفا و المروة",
                  trackNumber: 3,
                  isCompleted: controller.currentStep > 2,
                  imgPath: "assets/images/step-3.png",
                ),
              ),
              TrackCard(
                left: 240,
                top: 220,
                child: TrackCardUI(
                  isLeft: false,
                  title: "الحلق و التقصير",
                  trackNumber: 4,
                  isCompleted: controller.currentStep > 3,
                  imgPath: "assets/images/step-8.png",
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
