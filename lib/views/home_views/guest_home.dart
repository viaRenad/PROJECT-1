import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mulabbi/controllers/track_controller.dart';
import 'package:mulabbi/models/nusk_details.dart';
import 'package:mulabbi/views/home_views/articles/official_documents_view.dart';
import 'package:mulabbi/views/home_views/articles/pilgrim_bag_view.dart';
import 'package:mulabbi/views/shell/main_scaffold.dart';
import 'package:mulabbi/views/track_views/choose_nusk.dart';
import 'package:mulabbi/views/track_views/track_entry_view.dart';
import 'package:mulabbi/widgets/home_widgets/build_prayer_bar.dart';
import 'package:mulabbi/widgets/home_widgets/date_and_title_row.dart';
import 'package:mulabbi/widgets/home_widgets/info_image_card.dart';
import 'package:mulabbi/widgets/home_widgets/journey_attachments.dart';
import 'package:mulabbi/widgets/home_widgets/start_card.dart';
import 'package:mulabbi/core/colors.dart';
import 'package:mulabbi/widgets/track_widgets/track_detail.dart';

class GuestHome extends StatefulWidget {
  const GuestHome({super.key});

  @override
  State<GuestHome> createState() => _GuestHomeState();
}

class _GuestHomeState extends State<GuestHome> {
  @override
  Widget build(BuildContext context) {
    final trackController = Get.put(TrackController());
    return Stack(
      children: [
        // 0️⃣ Full-screen background
        Container(
          color: const Color.fromARGB(255, 128, 74, 27),
          width: double.infinity,
          height: double.infinity,
        ),

        // 1️⃣ Kaaba image + its gradient
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            width: double.infinity,
            height: 240,
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color.fromARGB(255, 128, 74, 27),
                width: 4,
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(55),
                topRight: Radius.circular(55),
              ),
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(55),
                topRight: Radius.circular(55),
              ),
              child: Stack(
                children: [
                  Image.asset(
                    'assets/images/kabba_home.png',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                  Container(
                    height: 101,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color.fromRGBO(255, 255, 255, 0.82),
                          Color.fromRGBO(153, 153, 153, 0.22),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        // 2️⃣ White rounded curve background
        Positioned(
          top: 215,
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            height: 50,
            decoration: const BoxDecoration(
              color: Color(0xFFF5F2EE),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50),
              ),
            ),
          ),
        ),

        // 3️⃣ Foreground scrollable content
        Positioned.fill(
          top: 200,
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(
              top: 70,
            ), // push content below prayer bar
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const DateAndTitleRow(),
                const SizedBox(height: 10),

                // 🟤 Start Journey Cards
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: FutureBuilder(
                    future: trackController.getUserCurrentStep(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: AppColorBrown.gradientColors.first,
                          ),
                        );
                      }
                      if (!trackController.isTrackActive) {
                        return Row(
                          children: [
                            // ⚪️ Umrah
                            Expanded(
                              child: InkWell(
                                onTap: () async {
                                  await trackController.getUserCurrentStep();
                                  if (trackController.isPending) return;
                                  trackController.registerNewTrack(4);
                                },
                                child: StartCard(
                                  title: 'بدء العمرة',
                                  subtitle: 'متاحة طوال العام',
                                  gradient: AppColorGrey.umrah,
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            // 🟤 Hajj
                            Expanded(
                              child: InkWell(
                                onTap: () async {
                                  await trackController.getUserCurrentStep();
                                  if (trackController.currentUserId == null) {
                                    Get.to(
                                      () => MainScaffold(
                                        userType: UserType.guest,
                                        index: 2,
                                      ),
                                    );
                                    return;
                                  }
                                  Get.to(() => ChooseNuskView());
                                },
                                child: StartCard(
                                  title: 'بدء الحج',
                                  subtitle: 'متاح في أيام محددة فقط',
                                  gradient: AppColorBrown.quran,
                                ),
                              ),
                            ),
                          ],
                        );
                      }
                      Steps? stepInfo = trackController.stepInfo;

                      return Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          gradient:
                              trackController.type == "umrah"
                                  ? AppColorGrey.umrah
                                  : AppColorBrown.hajj,
                        ),
                        child: Row(
                          spacing: 8,
                          textDirection: TextDirection.rtl,
                          children: [
                            Expanded(
                              child: Image.asset(
                                stepInfo?.shortImage ??
                                    "assets/images/step-short-1.png",
                                width: 180,
                                height: 93,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: SizedBox(
                                  child: Column(
                                    spacing: 4,
                                    textDirection: TextDirection.rtl,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        stepInfo?.shortTitle ?? "النسك الحالي",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                          color: Colors.white,
                                        ),
                                        textDirection: TextDirection.rtl,
                                      ),
                                      Text(
                                        stepInfo?.shortDescription ??
                                            "وصف للنسك الحالي",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 10,
                                          color: Colors.white,
                                        ),
                                        textDirection: TextDirection.rtl,
                                      ),
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              left: 5.0,
                                            ),
                                            child: InkWell(
                                              onTap: () {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return TrackDetail(
                                                      title:
                                                          stepInfo
                                                              ?.shortTitle ??
                                                          "عنوان للنسك",
                                                      trackNumber:
                                                          trackController
                                                              .getCurrentStep(),
                                                      details:
                                                          stepInfo?.details,
                                                      isReadOnly: true,
                                                    );
                                                  },
                                                );
                                              },
                                              child: Container(
                                                padding: EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                  color: Color(0xFFD9A96B),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                        100,
                                                      ),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                      Icons.arrow_back_ios,
                                                      size: 9,
                                                      color: Colors.black,
                                                    ),
                                                    Text(
                                                      "عرض التفاصيل",
                                                      style: TextStyle(
                                                        fontSize: 8,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 1),

                const JourneyAttachments(),

                // 🏷 Section Title: قبل رحلتك للحج أو العمرة
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(),
                      ShaderMask(
                        shaderCallback:
                            (bounds) =>
                                AppColorBrown.unlocked.createShader(bounds),
                        blendMode: BlendMode.srcIn,
                        child: Text(
                          'قبل رحلتك للحج أو العمرة',
                          style: TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // 📋 Horizontal Scrollable Info Cards Section
                SizedBox(
                  height:
                      105, // Increased height for better subtitle visibility
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    reverse: true, // This makes the list start from the right
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    children: [
                      // 📌 First card
                      SizedBox(
                        width: 322,
                        child: InfoImageCard(
                          imagePath: 'assets/images/passport_card.png',
                          title: 'الوثائق الرسمية',
                          subtitle: 'دليل وثائقك لعبور سلس وصحيح',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => const OfficialDocumentsView(),
                              ),
                            );
                          },
                          imageWidth: 150, // 👈 customize here
                          imageHeight: 250, // 👈 customize here
                        ),
                      ),

                      const SizedBox(width: 17),

                      // 📌 Second card
                      SizedBox(
                        width: 322,
                        child: InfoImageCard(
                          imagePath: 'assets/images/bag_cardd.png',
                          title: 'حقيبة الحاج',
                          subtitle: "جميع ما يلزمك لرحلة مريحة ومنظمة",
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const PilgrimBagView(),
                              ),
                            );
                          },
                          imageWidth: 150, // 👈 Set desired width
                          imageHeight: 250, // 👈 Set desired height
                        ),
                      ),

                      // ✅ Add more cards here as needed
                    ],
                  ),
                ),

                const SizedBox(height: 32),
              ],
            ),
          ),
        ),

        // 4️⃣ Prayer bar stays on top
        const Positioned(top: 198, left: 0, right: 0, child: PrayerBar()),
      ],
    );
  }
}
