import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mulabbi/controllers/track_controller.dart';
import 'package:mulabbi/core/colors.dart';
import 'package:mulabbi/models/nusk_details.dart';
import 'package:mulabbi/widgets/track_widgets/track_detail_description.dart';

class TrackDetail extends StatelessWidget {
  const TrackDetail({
    super.key,
    required this.title,
    required this.trackNumber,
    this.details,
    this.isLast,
  });
  final String title;
  final int trackNumber;
  final List<Details>? details;
  final bool? isLast;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TrackController());
    bool isCurrentStep = trackNumber == controller.getCurrentStep();
    bool isUmrah = controller.type == "umrah";
    String? timing =
        controller.nusks.first.steps?.elementAt(trackNumber - 1).timing;
    return Dialog(
      alignment: Alignment.center,
      child: Container(
        padding: EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Color(0xFFF8F4ED),
          border: Border.all(color: Color(0xFF7E5A3B), width: 2),
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              offset: Offset(2, 3),
              color: const Color.fromARGB(33, 0, 0, 0),
              blurRadius: 222,
            ),
          ],
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ShaderMask(
                shaderCallback:
                    (bounds) =>
                        AppColorBrown.gradientBrown.createShader(bounds),
                child: Text(
                  title,
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text(
                timing ?? "التوقيت",
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF333333),
                ),
              ),
              SizedBox(height: 8),

              ...details!.map((detail) {
                return Column(
                  children: [Divider(), TrackDetailDescription(detail: detail)],
                );
              }).toList(),

              SizedBox(height: 43),
              InkWell(
                onTap: () {
                  if (!isCurrentStep) return;
                  if (isLast == true) {
                    controller.endTracking();
                    return;
                  }
                  controller.incrementStep();
                  Get.back();
                },
                child: Container(
                  width: 236,
                  height: 47,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(44),
                    gradient:
                        isCurrentStep
                            ? AppColorBrown.gradientBrown
                            : trackNumber > controller.getCurrentStep()
                            ? AppColorGrey.lockedNumber
                            : AppColorGreen.greenish,
                  ),

                  child: Center(
                    child: Text(
                      isLast == true
                          ? isUmrah
                              ? "إتمام العمرة"
                              : "إتمام الحج"
                          : isCurrentStep
                          ? "انتقل للخطوة القادمة"
                          : trackNumber > controller.getCurrentStep()
                          ? "لم تصل للخطوة الحالية"
                          : "لقد اتممت هذه الخطوة",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
