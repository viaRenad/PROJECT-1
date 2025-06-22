import 'package:get/get.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:mulabbi/main.dart';
import 'package:mulabbi/models/nusk_details.dart';
import 'package:mulabbi/views/shell/main_scaffold.dart';

class TrackController extends GetxController {
  String? currentUserId;
  RxInt currentStep = 1.obs;
  int progressId = -1;
  bool isTrackActive = false;
  String type = "";

  List<nusks_details> nusks = [];

  Future<void> getUserCurrentStep() async {
    final token = await storage.getString("token");
    final userRes = await supabase.auth.getUser(token);
    currentUserId = userRes.user?.id;
    try {
      final doesUserExist = await supabase
          .from("users")
          .select("id")
          .eq("id", currentUserId!);
      doesUserExist.first; // if there's nothing it will throw error
    } catch (e) {
      currentUserId = null;
      return;
    }

    try {
      final response = await supabase
          .from("user_nusuk_progress")
          .select('''
    user_nusuk_pr_id,
    step_number,
    completed_at,
    user_nusuk (
      user_id,
      nusuk_id (
        nusuk_type
      )
    )
''')
          .eq("user_nusuk.user_id", currentUserId!)
          .or("completed_at.is.null");
      final data = response.first;
      if (data["completed_at"] != null || data["user_nusuk"] == null) {
        isTrackActive = false;
        throw Error();
      }

      // data look like this: {step_number: 1, user_nusuk: {nusuk_id: {nusuk_type: ifrad}}}
      isTrackActive = true;
      currentStep.value = data["step_number"];
      type = data["user_nusuk"]["nusuk_id"]["nusuk_type"];
      progressId = data["user_nusuk_pr_id"];

      // REALTIME
      supabase
          .from('user_nusuk_progress')
          .stream(primaryKey: ['user_nusuk_pr_id'])
          .eq("user_nusuk_pr_id", data["user_nusuk_pr_id"])
          .listen((List<Map<String, dynamic>> data) {
            currentStep.value = data.first["step_number"];
          });
    } catch (e) {
      print(e);
    }
  }

  Future<void> setNuskDetails(String type) async {
    try {
      final String jsonString = await rootBundle.loadString(
        'lib/data/nusk_details.json',
      );
      final List<dynamic> jsonData = json.decode(jsonString);
      nusks = jsonData.map((json) => nusks_details.fromJson(json)).toList();
      nusks = nusks.where((nusk) => nusk.type == type).toList();
      update();
      // ignore: empty_catches
    } catch (e) {}
  }

  int getCurrentStep() {
    return currentStep.toInt();
  }

  incrementStep() async => {
    await supabase
        .from("user_nusuk_progress")
        .update({"step_number": getCurrentStep() + 1})
        .eq("user_nusuk_pr_id", progressId),
  };

  void registerNewTrack(int nusukId) async {
    if (isTrackActive) return;

    final nusuk = await supabase
        .from("user_nusuk")
        .insert({"user_id": currentUserId, "nusuk_id": nusukId})
        .select('''
                        user_nusuk_id,
                        nusuk_id(
                          nusuk_type  
                        )
                      ''');
    final progress =
        await supabase.from("user_nusuk_progress").insert({
          "user_nusuk_id": nusuk.first["user_nusuk_id"],
          "step_number": 1,
        }).select();
    progressId = progress.first["user_nusuk_pr_id"];
    type = nusuk.first["nusuk_id"]["nusuk_type"];
    currentStep.value = 1;

    Get.reloadAll();
    Get.to(() => MainScaffold(userType: UserType.user, index: 2));
  }

  void endTracking() async {
    await supabase
        .from("user_nusuk_progress")
        .update({"completed_at": DateTime.now().toString()})
        .eq("user_nusuk_pr_id", progressId);

    currentStep.value = 1;
    progressId = -1;
    type = "";
    isTrackActive = false;
    Get.reload();
    Get.to(() => MainScaffold(userType: UserType.user, index: 2));
  }
}
