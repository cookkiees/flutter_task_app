import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:task_app/app/core/services/firebase_result.dart';
import 'package:task_app/app/core/services/firebase_result_type.dart';

import '../helpers/task_logger.dart';
import 'firebase_request.dart';
import 'firebase_request_method.dart';

class FirebaseFirestoreService extends GetConnect {
  Future<FirestoreResult<DocumentSnapshot>> firestoreRequestUser(
      FirebaseFirestoreRequest request) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    DocumentSnapshot documentSnapshot;
    try {
      switch (request.method) {
        case FirestoreRequestMethod.get:
          documentSnapshot = await firestore
              .collection(request.collection)
              .doc(request.documentId)
              .get();
          debugPrintFirestore(request, documentSnapshot.data());
          return FirestoreResult(
            result: FirestoreResultType.success,
            data: documentSnapshot,
            errorMessage: '',
          );
        case FirestoreRequestMethod.post:
          await firestore
              .collection(request.collection)
              .doc(request.documentId)
              .set(request.data!);
          return FirestoreResult(
            result: FirestoreResultType.success,
            errorMessage: '',
          );
        default:
          return FirestoreResult(
            result: FirestoreResultType.failure,
            errorMessage: 'Unsupported request method.',
          );
      }
    } catch (error) {
      return FirestoreResult(
        result: FirestoreResultType.failure,
        errorMessage: error.toString(),
      );
    } finally {}
  }

  Future<void> debugPrintFirestore(
      FirebaseFirestoreRequest request, Object? documentSnapshot) async {
    TaskLogger.logDebug(
        '----------------- FIREBASE FIRESTORE -----------------');
    TaskLogger.logDebug('Method: ${request.method}');
    TaskLogger.logDebug('Collection: ${request.collection}');
    TaskLogger.logDebug('Document ID: ${request.documentId}');
    TaskLogger.logDebug('Data: $documentSnapshot');
    TaskLogger.logDebug(
        '------------------------------------------------------');
  }
}
