// controllers/duaa_controller.dart

import 'package:get/get.dart';
import 'package:mulabbi/data/adiyah_data.dart';
import 'package:mulabbi/models/dua_model.dart';

class DuasController extends GetxController {
  var allDuas = <String, List<ContentItem>>{}.obs;

  @override
  void onInit() {
    super.onInit();
    loadDuasFromDart();
  }

  void loadDuasFromDart() {
    allDuas.value = duasData;
  }
}
