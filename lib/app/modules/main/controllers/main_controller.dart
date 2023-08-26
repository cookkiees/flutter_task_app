import 'package:get/get.dart';

import '../../../core/services/firebase_firestore_service.dart';
import 'main_repository.dart';

class MainController extends GetxController {
  MainRepository repository = Get.find<MainRepository>();
  final firestore = Get.find<FirebaseFirestoreService>();

  var selectedIndex = 0.obs;

  void changeTab(int index) {
    selectedIndex.value = index;
  }
}
