import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/helpers/task_info.dart';
import '../../../../core/services/firebase_firestore_service.dart';
import '../../../../core/services/firebase_request.dart';
import '../../../../core/services/firebase_request_method.dart';
import '../../../../core/services/firebase_result_type.dart';
import '../../../../routes/app_routes.dart';
import '../../entities/user_base_entity.dart';
import 'sign_up_repository.dart';

class SignUpController extends GetxController {
  final worker = Get.find<SignUpRepository>();
  final firestoreService = Get.find<FirebaseFirestoreService>();
  final username = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();

  RxBool isLoadingSignUp = false.obs;
  RxBool isHide = false.obs;

  UserBaseEntity? _userEntity;

  resetField() {
    username.text = '';
    email.text = '';
    password.text = '';
  }

  void handleSignUp() async {
    try {
      isLoadingSignUp.value = true;
      final firebaseResult =
          await worker.prosesSignUp(email.text, password.text);
      if (firebaseResult.result == FirebaseResultType.success) {
        final user = firebaseResult.data!.user;
        _userEntity =
            UserBaseEntity.fromFirebase(user!, username: username.text);
        if (_userEntity != null) {
          Map<String, dynamic> userMap = _userEntity!.toFirebase();
          final firestoreRequest = FirebaseFirestoreRequest(
            method: FirestoreRequestMethod.post,
            collection: 'users',
            documentId: _userEntity!.email,
            data: userMap,
          );
          await firestoreService.firestoreRequestUser(firestoreRequest);
          Get.toNamed(AppRoutes.signIn);
        }
        TaskInfo.showSnackBar(
            "Sign Up successful. Please proceed to log in ${username.text}");
      } else if (firebaseResult.result == FirebaseResultType.failure) {
        TaskInfo.showSnackBar("${firebaseResult.message}");
      }
    } finally {
      isLoadingSignUp.value = false;
      resetField();
    }
  }
}
