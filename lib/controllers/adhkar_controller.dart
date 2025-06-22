// controllers/duaa_controller.dart

import 'package:get/get.dart';
import 'package:mulabbi/data/adhkar_data.dart';
import 'package:mulabbi/models/adhkar_model.dart';

class AdhkarController extends GetxController {
  var allDuas = <String, List<ContentItem>>{}.obs;

  @override
  void onInit() {
    super.onInit();
    loadDuasFromDart();
  }

  void loadDuasFromDart() {
    allDuas.value = adhkarData;
  }
}
