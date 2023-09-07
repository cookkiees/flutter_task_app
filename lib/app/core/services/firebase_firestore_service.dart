import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../modules/schedule/entities/schedule_base_entity.dart';
import '../helpers/task_logger.dart';
import '../local_storage/shared_preference.dart';
import 'firebase_request.dart';
import 'firebase_request_method.dart';
import 'firebase_result.dart';
import 'firebase_result_type.dart';

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
            meessage: '',
          );
        case FirestoreRequestMethod.post:
          await firestore
              .collection(request.collection)
              .doc(request.documentId)
              .set(request.data!);
          return FirestoreResult(
            result: FirestoreResultType.success,
            meessage: '',
          );
        default:
          return FirestoreResult(
            result: FirestoreResultType.failure,
            meessage: 'Unsupported request method.',
          );
      }
    } catch (error) {
      return FirestoreResult(
        result: FirestoreResultType.failure,
        meessage: error.toString(),
      );
    }
  }

  Future<void> debugPrintFirestore(
      FirebaseFirestoreRequest request, Object? documentSnapshot) async {
    TaskLogger.logDebug('----------------- FIRESTORE USER -----------------');
    TaskLogger.logDebug('Method: ${request.method}');
    TaskLogger.logDebug('Collection: ${request.collection}');
    TaskLogger.logDebug('Document ID: ${request.documentId}');
    TaskLogger.logDebug('Data: $documentSnapshot');
    TaskLogger.logDebug('----------------------------------------------------');
  }

  Future<FirestoreResult<List<ScheduleBaseEntity>>> firestoreRequestTask(
      FirestoreRequestTask request) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    QuerySnapshot querySnapshot;
    final userEmail = await SharedPref.getAccessTokenFrom();

    ScheduleBaseEntity scheduleEntityFromDocumentSnapshot(
        QueryDocumentSnapshot doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      return ScheduleBaseEntity.fromFirestoreData(data);
    }

    try {
      switch (request.method) {
        case FirestoreRequestMethod.getbySelectedDateTask:
          querySnapshot = await firestore
              .collection('task')
              .doc(userEmail)
              .collection('monthly')
              .doc(request.montly)
              .collection("${request.date}")
              .get();
          final monthlyTask = querySnapshot.docs;
          List<ScheduleBaseEntity> monthlyTaskEntities = monthlyTask
              .map((doc) => scheduleEntityFromDocumentSnapshot(doc))
              .toList();

          debugPrintFirestoreTask(request, userEmail, monthlyTaskEntities);
          return FirestoreResult(
            result: FirestoreResultType.success,
            data: monthlyTaskEntities,
            meessage: '',
          );
        case FirestoreRequestMethod.getUpComingTask:
          final now = DateTime.now();
          final tomorrow = now.add(const Duration(days: 1));
          final formattedTomorrow = DateFormat.d().format(tomorrow);
          final DateFormat monthFormatter = DateFormat('MMMM');
          final String formattedMonth = monthFormatter.format(now);
          querySnapshot = await firestore
              .collection('task')
              .doc(userEmail)
              .collection('monthly')
              .doc(formattedMonth)
              .collection(formattedTomorrow)
              .get();
          final monthlyTask = querySnapshot.docs;
          List<ScheduleBaseEntity> monthlyTaskEntities = monthlyTask
              .map((doc) => scheduleEntityFromDocumentSnapshot(doc))
              .toList();

          debugPrintFirestoreTask(request, userEmail, monthlyTaskEntities);
          return FirestoreResult(
            result: FirestoreResultType.success,
            data: monthlyTaskEntities,
            meessage: '',
          );
        case FirestoreRequestMethod.getTodayTask:
          final now = DateTime.now();
          final DateFormat monthFormatter = DateFormat('MMMM');
          final String formattedMonth = monthFormatter.format(now);
          final DateFormat dayFormatter = DateFormat('d');
          final String formattedDay = dayFormatter.format(now);
          querySnapshot = await firestore
              .collection('task')
              .doc(userEmail)
              .collection('monthly')
              .doc(formattedMonth)
              .collection(formattedDay)
              .get();
          final monthlyTask = querySnapshot.docs;
          List<ScheduleBaseEntity> monthlyTaskEntities = monthlyTask
              .map((doc) => scheduleEntityFromDocumentSnapshot(doc))
              .toList();

          debugPrintFirestoreTask(request, userEmail, monthlyTaskEntities);
          return FirestoreResult(
            result: FirestoreResultType.success,
            data: monthlyTaskEntities,
            meessage: '',
          );
        case FirestoreRequestMethod.createTask:
          DateTime currentDate = DateTime.now();
          DateTime requestDate = request.data!['date'];
          String requestTimeStr = request.data!['time'] as String;
          List<String> timeComponents = requestTimeStr.split(':');
          TimeOfDay requestTime = TimeOfDay(
            hour: int.parse(timeComponents[0]),
            minute: int.parse(timeComponents[1]),
          );
          DateTime requestDateTime = DateTime(
            requestDate.year,
            requestDate.month,
            requestDate.day,
            requestTime.hour,
            requestTime.minute,
          );
          if (requestDateTime.isBefore(currentDate)) {
            return FirestoreResult(
              result: FirestoreResultType.failure,
              meessage: 'Cannot add data to past months or time.',
            );
          } else {
            final task = FirebaseFirestore.instance.collection('task');
            String releaseDate = DateFormat.MMMMd().format(requestDate);
            String date = DateFormat.d().format(requestDate);
            String timeString = requestTime.toString();
            String releaseTime = timeString.replaceAll(RegExp(r'[^\d:]'), '');

            final snapshot = await task
                .doc(userEmail)
                .collection('monthly')
                .doc(request.montly)
                .collection(date)
                .get();

            int taskId = calculateNewTaskId(snapshot.docs);

            final DocumentReference documentRef = firestore
                .collection('task')
                .doc(userEmail)
                .collection('monthly')
                .doc(request.montly)
                .collection(date)
                .doc("$taskId");
            await documentRef.set(request.data);
            await documentRef.update({
              'id': "$taskId",
              'date': releaseDate,
              'time': releaseTime,
            });

            debugPrintFirestoreTask(request, userEmail, null);
            return FirestoreResult(
              result: FirestoreResultType.success,
              meessage: 'A new task has been added',
            );
          }
        default:
          return FirestoreResult(
            result: FirestoreResultType.failure,
            meessage: 'Unsupported request method.',
          );
      }
    } catch (error) {
      return FirestoreResult(
        result: FirestoreResultType.failure,
        meessage: error.toString(),
      );
    }
  }

  int calculateNewTaskId(List<DocumentSnapshot> categoryDocs) {
    int maxId = 0;
    for (var doc in categoryDocs) {
      final id = int.tryParse(doc['id']);
      if (id != null && id > maxId) {
        maxId = id;
      }
    }
    return maxId + 1;
  }

  Future<void> debugPrintFirestoreTask(FirestoreRequestTask? request,
      String? documentId, List<ScheduleBaseEntity>? entity) async {
    TaskLogger.logDebug('----------------- FIREBASE TASK  -----------------');
    TaskLogger.logDebug('Method: ${request!.method}');
    if (request.data != null || entity != []) {
      TaskLogger.logDebug('Status: SUCCESS');
    } else {
      TaskLogger.logDebug('Status: FAILURE');
    }
    TaskLogger.logDebug('Collection : ${'TASK'}');
    TaskLogger.logDebug('Document : $documentId');
    TaskLogger.logDebug('Collection : ${'MONTHLY'}');
    TaskLogger.logDebug('Document : ${request.montly ?? '-'}');
    TaskLogger.logDebug('Collection : ${request.date ?? '-'}');
    if (request.data != null) {
      TaskLogger.logDebug('Document : ${request.data}');
    }
    if (entity != null) {
      TaskLogger.logDebug('Document : $entity');
    }

    TaskLogger.logDebug('-------------------------------------------------');
  }
}
