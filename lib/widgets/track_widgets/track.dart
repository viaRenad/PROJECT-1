import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mulabbi/controllers/track_controller.dart';
import 'package:mulabbi/core/colors.dart';

class Track extends StatelessWidget {
  const Track({
    super.key,
    required this.type,
    required this.nuskTitle,
    required this.tracks,
    required this.trackCards,
    this.height,
  });
  final String type;
  final String nuskTitle;
  final List<Positioned> tracks;
  final GetX trackCards;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TrackController());
    controller.setNuskDetails(type);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 25.0),
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Image.asset("assets/images/steps-background.png"),
              Positioned(
                bottom: 150,
                child: Image.asset(
                  "assets/images/steps-fill.png",
                  width: 500,
                  height: height == null ? null : height! - 400,
                  fit: BoxFit.contain,
                ),
              ),
              Positioned(
                bottom: -310,
                child: Image.asset(
                  "assets/images/steps-fill.png",
                  width: 500,
                  height: height == null ? null : height! - 400,
                  fit: BoxFit.contain,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 270.0, bottom: 24),
                child: Column(
                  children: [
                    ShaderMask(
                      shaderCallback:
                          (bounds) => AppColorBrown.gradientPrimary
                              .createShader(bounds),
                      child: Text(
                        nuskTitle,
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 48),
                    SizedBox(
                      width: 400,
                      height: height ?? 400,
                      child: Stack(
                        alignment: Alignment.topCenter,
                        children: [...tracks.map((track) => track), trackCards],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
