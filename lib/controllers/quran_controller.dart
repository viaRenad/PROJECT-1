import 'package:get/get.dart';

class QuranController extends GetxController {
  RxInt page = 1.obs;
  RxInt surah = 1.obs;
  RxInt selectedSurah = 1.obs; // 🆕 Selected Surah for UI highlight
  RxString searchText = ''.obs; // ✅ For search bar filtering

  int getPage() {
    return page.value;
  }

  int getSurah() {
    return surah.value;
  }

  void incrementPage() {
    if (page.value < 604) {
      page.value++;
    }
  }

  void decrementPage() {
    if (page.value > 1) {
      page.value--;
    }
  }

  void setPage(int pageNumber) {
    if (pageNumber >= 1 && pageNumber <= 604) {
      page.value = pageNumber;
    }
    update();
  }

  void incrementSurah() {
    if (surah.value < 114) {
      surah.value++;
    }
  }

  void decrementSurah() {
    if (surah.value > 1) {
      surah.value--;
    }
  }

  void setSurah(int surahNumber) {
    if (surahNumber >= 1 && surahNumber <= 114) {
      surah.value = surahNumber;
    }
    update();
  }

  void setSelectedSurah(int surahNumber) {
    if (surahNumber >= 1 && surahNumber <= 114) {
      selectedSurah.value = surahNumber;
    }
  }

  // ✅ Only this was added
  void updateSearch(String value) {
    searchText.value = value;
  }
}
