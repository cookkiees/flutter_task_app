import 'package:get/get.dart';

import '../../../../core/services/firebase_firestore_service.dart';
import '../../../../core/services/firebase_service.dart';
import 'sign_in_controller.dart';
import 'sign_in_repository.dart';

class SignInBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FirebaseService>(() => FirebaseService());
    Get.lazyPut<SignInRepository>(() => SignInRepository());
    Get.lazyPut<FirebaseFirestoreService>(() => FirebaseFirestoreService());
    Get.lazyPut<SignInController>(() => SignInController());
  }
}
