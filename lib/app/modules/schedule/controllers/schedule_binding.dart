import 'package:get/get.dart';

import '../../../core/services/firebase_firestore_service.dart';
import 'schedule_controller.dart';
import 'schedule_repository.dart';

class ScheduleBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FirebaseFirestoreService>(() => FirebaseFirestoreService());
    Get.lazyPut<ScheduleRepository>(() => ScheduleRepository());
    Get.lazyPut<ScheduleController>(() => ScheduleController());
  }
}
