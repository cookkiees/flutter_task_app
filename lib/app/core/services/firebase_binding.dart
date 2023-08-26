import 'package:get/get.dart';

import 'firebase_firestore_service.dart';
import 'firebase_service.dart';

class FirebaseBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FirebaseService>(() => FirebaseService());
    Get.lazyPut<FirebaseFirestoreService>(() => FirebaseFirestoreService());
  }
}
