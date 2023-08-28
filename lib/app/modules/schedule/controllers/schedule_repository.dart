import 'package:get/get.dart';
import 'package:task_app/app/core/services/firebase_firestore_service.dart';
import 'package:task_app/app/core/services/firebase_request_method.dart';

import '../../../core/services/firebase_request.dart';
import '../../../core/services/firebase_result.dart';

class ScheduleRepository {
  FirebaseFirestoreService service = Get.find<FirebaseFirestoreService>();

  Future<FirestoreResult> prosesCreateTask(
      Map<String, dynamic>? data, String montly) async {
    FirestoreRequestTask request = FirestoreRequestTask(
      method: FirestoreRequestMethod.post,
      data: data,
      montly: montly,
    );
    final firestoreResult = await service.firestoreRequestTask(request);
    return firestoreResult;
  }

  Future<FirestoreResult> prosesGetMonthlyTask(
      String montly, String date) async {
    FirestoreRequestTask request = FirestoreRequestTask(
      method: FirestoreRequestMethod.get,
      montly: montly,
      date: date,
    );
    final firestoreResult = await service.firestoreRequestTask(request);
    return firestoreResult;
  }
}
