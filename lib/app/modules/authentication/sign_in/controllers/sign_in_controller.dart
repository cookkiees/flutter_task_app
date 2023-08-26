import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_app/app/routes/app_routes.dart';

import '../../../../core/helpers/task_info.dart';
import '../../../../core/helpers/task_logger.dart';
import '../../../../core/local_storage/shared_preference.dart';
import '../../../../core/services/firebase_firestore_service.dart';
import '../../../../core/services/firebase_request.dart';
import '../../../../core/services/firebase_request_method.dart';
import '../../../../core/services/firebase_result_type.dart';
import '../../entities/user_base_entity.dart';
import '../../models/user_base_view_model.dart';
import 'sign_in_repository.dart';

class SignInController extends GetxController {
  final worker = Get.find<SignInRepository>();
  final firestore = Get.find<FirebaseFirestoreService>();

  final email = TextEditingController();
  final password = TextEditingController();

  RxBool isHide = false.obs;
  RxBool isLoadingSignIn = false.obs;
  RxBool isLoadingGoogleSignIn = false.obs;

  UserBaseViewModel? userViewModel;
  UserBaseEntity? _userEntity;

  resetField() {
    email.text = '';
    password.text = '';
  }

  Future<void> handleGoogleSignIn() async {
    isLoadingGoogleSignIn.value = true;
    try {
      final firebaseResult = await worker.prosesGoogleSignIn();
      if (firebaseResult.result == FirebaseResultType.success) {
        User? currentUser = FirebaseAuth.instance.currentUser;
        FirebaseFirestoreRequest firestoreRequest;
        if (currentUser != null) {
          _userEntity = UserBaseEntity.fromFirebase(currentUser);
          if (_userEntity != null) {
            final data = _userEntity?.toFirebase();
            firestoreRequest = FirebaseFirestoreRequest(
              method: FirestoreRequestMethod.get,
              collection: 'users',
              documentId: _userEntity!.email,
            );
            await fetchUserAndConvertViewModel(
              firestoreRequest,
              docId: _userEntity!.email,
              data: data,
            );
          }
          Get.offAllNamed(AppRoutes.main, arguments: userViewModel);
        }
      } else if (firebaseResult.result == FirebaseResultType.failure) {
        TaskInfo.showSnackBar("${firebaseResult.message}");
      }
    } finally {
      isLoadingGoogleSignIn.value = false;
    }
  }

  Future<void> handleSignIn() async {
    isLoadingSignIn.value = true;
    try {
      final firebaseResult =
          await worker.prosesSignIn(email.text, password.text);
      if (firebaseResult.result == FirebaseResultType.success) {
        final user = firebaseResult.data!.user;
        if (user != null) {
          final firestoreRequest = FirebaseFirestoreRequest(
            method: FirestoreRequestMethod.get,
            collection: 'users',
            documentId: user.email,
          );
          await fetchUserAndConvertViewModel(firestoreRequest);

          Get.offAllNamed(AppRoutes.main, arguments: userViewModel);
        }
      } else if (firebaseResult.result == FirebaseResultType.failure) {
        TaskInfo.showSnackBar("${firebaseResult.message}");
      }
    } finally {
      resetField();
      isLoadingSignIn.value = false;
    }
  }

  Future<UserBaseViewModel?> fetchUserAndConvertViewModel(
      FirebaseFirestoreRequest firestoreRequest,
      {String? docId,
      Map<String, dynamic>? data}) async {
    final response = await firestore.firestoreRequestUser(firestoreRequest);
    if (response.result == FirestoreResultType.success) {
      final firestoreData = response.data;
      if (firestoreData?.exists ?? false) {
        final results = firestoreData!.data() as Map<String, dynamic>;
        final data = UserBaseEntity.fromFirestoreData(results);
        userViewModel = UserBaseViewModel.fromEntity(data);
        return userViewModel;
      } else {
        final newUserRequest = FirebaseFirestoreRequest(
          method: FirestoreRequestMethod.post,
          collection: 'users',
          documentId: docId,
          data: data,
        );
        final response = await firestore.firestoreRequestUser(newUserRequest);
        if (response.result == FirestoreResultType.success) {
          final newData = UserBaseEntity.fromFirestoreData(data!);
          userViewModel = UserBaseViewModel.fromEntity(newData);
        }
        return userViewModel;
      }
    } else {
      return null;
    }
  }
}
