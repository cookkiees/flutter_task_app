import 'package:get/get.dart';
import 'package:task_app/app/core/services/firebase_service.dart';

import '../../../../core/services/firebase_firestore_service.dart';
import 'sign_up_controller.dart';
import 'sign_up_repository.dart';

class SignUpBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FirebaseService>(() => FirebaseService());
    Get.lazyPut<SignUpRepository>(() => SignUpRepository());
    Get.lazyPut<FirebaseFirestoreService>(() => FirebaseFirestoreService());
    Get.lazyPut<SignUpController>(() => SignUpController());
  }
}
