import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mulabbi/controllers/track_controller.dart';
import 'package:mulabbi/core/colors.dart';
import 'package:mulabbi/models/nusk_details.dart';
import 'package:mulabbi/widgets/track_widgets/track_detail.dart';

class TrackCardUI extends StatelessWidget {
  const TrackCardUI({
    super.key,
    required this.title,
    required this.isCompleted,
    required this.trackNumber,
    this.isLeft,
    this.imgPath,
  });
  final bool isCompleted;
  final int trackNumber;
  final String title;
  final String? imgPath;
  final bool? isLeft;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TrackController());
    late List<Details>? details =
        controller.nusks.first.steps?.elementAt(trackNumber - 1).details;
    late bool isLast = controller.nusks.first.steps!.length == trackNumber;
    return SizedBox(
      width: 160,
      child: InkWell(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) {
              return TrackDetail(
                title: title,
                trackNumber: trackNumber,
                details: details,
                isLast: isLast,
              );
            },
          );
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 5,
          children: [
            isLeft ?? true
                ? InkWell(
                  child: Row(
                    children: [
                      Column(
                        children: [
                          ColorFiltered(
                            colorFilter:
                                !isCompleted
                                    ? ColorFilter.matrix([
                                      0.2126,
                                      0.7152,
                                      0.0722,
                                      0,
                                      0,
                                      0.2126,
                                      0.7152,
                                      0.0722,
                                      0,
                                      0,
                                      0.2126,
                                      0.7152,
                                      0.0722,
                                      0,
                                      0,
                                      0,
                                      0,
                                      0,
                                      1,
                                      0,
                                    ])
                                    : ColorFilter.mode(
                                      Colors.transparent,
                                      BlendMode.color,
                                    ),
                            child: Image.asset(
                              imgPath ?? "assets/images/step-1.png",
                              width: 50,
                              height: 50,
                              fit: BoxFit.contain,
                            ),
                          ),
                          SizedBox(
                            width: 60,
                            child: Text(
                              title,
                              textAlign: TextAlign.center,
                              softWrap: true,
                              style: TextStyle(
                                color:
                                    isCompleted
                                        ? Color(0xFF7E5A3B)
                                        : Color(0xFF818181),
                                fontWeight: FontWeight.w900,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
                : SizedBox(),
            Container(
              width: 30,
              height: 30,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                gradient:
                    isCompleted
                        ? AppColorBrown.diagonal
                        : AppColorGrey.lockedNumber,
              ),

              child: Text(
                trackNumber.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            isLeft != null && isLeft == false
                ? Column(
                  children: [
                    ColorFiltered(
                      colorFilter:
                          !isCompleted
                              ? ColorFilter.matrix([
                                0.2126,
                                0.7152,
                                0.0722,
                                0,
                                0,
                                0.2126,
                                0.7152,
                                0.0722,
                                0,
                                0,
                                0.2126,
                                0.7152,
                                0.0722,
                                0,
                                0,
                                0,
                                0,
                                0,
                                1,
                                0,
                              ])
                              : ColorFilter.mode(
                                Colors.transparent,
                                BlendMode.color,
                              ),
                      child: Image.asset(
                        imgPath ?? "assets/images/step-1.png",
                        width: 50,
                        height: 50,
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(
                      width: 70,
                      child: Text(
                        title,
                        textAlign: TextAlign.center,
                        softWrap: true,

                        style: TextStyle(
                          color:
                              isCompleted
                                  ? Color(0xFF7E5A3B)
                                  : Color(0xFF818181),
                          fontWeight: FontWeight.w900,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}

class TrackCard extends Positioned {
  const TrackCard({
    super.key,
    super.top,
    super.bottom,
    super.left,
    super.right,
    required super.child,
  });
}
