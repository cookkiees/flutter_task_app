import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:task_app/app/core/services/firebase_firestore_service.dart';

import '../../../core/local_storage/shared_preference.dart';
import '../../../core/services/firebase_request.dart';
import '../../../core/services/firebase_request_method.dart';
import '../../../core/services/firebase_result.dart';

class HomeRepository {
  FirebaseFirestoreService service = Get.find<FirebaseFirestoreService>();

  Future<FirestoreResult<DocumentSnapshot<Object?>>> prossesGetUser() async {
    final userEmail = await SharedPref.getAccessTokenFrom();
    final firestoreRequest = FirebaseFirestoreRequest(
      method: FirestoreRequestMethod.get,
      collection: 'users',
      documentId: userEmail,
    );
    final response = await service.firestoreRequestUser(firestoreRequest);
    return response;
  }

  Future<FirestoreResult> prosesGetUpComingTask() async {
    FirestoreRequestTask request = FirestoreRequestTask(
      method: FirestoreRequestMethod.getUpComingTask,
    );
    final firestoreResult = await service.firestoreRequestTask(request);
    return firestoreResult;
  }

  Future<FirestoreResult> prosesGetTodayTask() async {
    FirestoreRequestTask request = FirestoreRequestTask(
      method: FirestoreRequestMethod.getTodayTask,
    );
    final firestoreResult = await service.firestoreRequestTask(request);
    return firestoreResult;
  }
}
