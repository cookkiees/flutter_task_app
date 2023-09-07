import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:task_app/app/core/helpers/task_logger.dart';

import '../../../core/helpers/task_info.dart';
import '../../../core/services/firebase_result_type.dart';
import '../entities/schedule_base_entity.dart';
import '../models/schedule_view_model.dart';
import 'schedule_repository.dart';

class ScheduleController extends GetxController {
  ScheduleRepository repository = Get.find<ScheduleRepository>();
  List<String> months = DateFormat('MMMM').dateSymbols.MONTHS;
  RxString selectedMonth = DateFormat('MMMM').format(DateTime.now()).obs;

  late ScrollController scrollController;
  RxInt selectedDay = RxInt(DateTime.now().day);
  Rx<DateTime?> selectedDate = Rx<DateTime?>(null);
  Rx<TimeOfDay?> selectedTime = Rx<TimeOfDay?>(null);
  Rx<String> selectedCategory = ''.obs;
  Rx<String> selectedPriority = ''.obs;

  void resetField() {
    title.text = '';
    notes.text = '';
    selectedDate.value = null;
    selectedTime.value = null;
    selectedPriority.value = '';
    selectedCategory.value = '';
  }

  void setSelectedPriority(String value) {
    selectedPriority.value = value;
  }

  void setSelectedCategory(String value) {
    selectedCategory.value = value;
  }

  void setSelectedDay(int day) {
    selectedDay.value = day;
  }

  List<String> weekdays = DateFormat('EEEE')
      .dateSymbols
      .WEEKDAYS
      .map((day) => day.substring(0, 3))
      .toList();

  List<int> getDaysForSelectedMonth() {
    int year = DateTime.now().year;
    int month = months.indexOf(selectedMonth.value) + 1;
    int daysInMonth = DateTime(year, month + 1, 0).day;
    return List<int>.generate(daysInMonth, (index) => index + 1);
  }

  void scrollToSelectedDay() {
    int selectedIndex = getDaysForSelectedMonth().indexOf(selectedDay.value);
    if (selectedIndex >= 0 && scrollController.hasClients) {
      Future.delayed(const Duration(milliseconds: 100), () {
        scrollController.jumpTo(selectedIndex * 45);
      });
    }
  }

  @override
  void onInit() {
    handleGetMonthlyTask(selectedMonth.value, selectedDay.value.toString());
    super.onInit();
    scrollController = ScrollController();
  }

  RxBool isLoadingCreateTask = false.obs;
  RxBool isLoadingGetMonthlyTask = false.obs;

  TextEditingController title = TextEditingController();
  TextEditingController notes = TextEditingController();

  List<ScheduleViewModel?> monthlyTask = [];

  Future<void> handleCraeteTask() async {
    isLoadingCreateTask.value = true;
    if (title.text.isEmpty || notes.text.isEmpty) {
      TaskInfo.showSnackBar("Enter a title and notes ");

      isLoadingCreateTask.value = false;
      return;
    }
    if (selectedDate.value == null || selectedTime.value == null) {
      TaskInfo.showSnackBar("Enter a date ");
      isLoadingCreateTask.value = false;
      return;
    }
    if (selectedPriority.value == '' || selectedPriority.value.isEmpty) {
      TaskInfo.showSnackBar("Enter a Priority ");
      isLoadingCreateTask.value = false;
      return;
    }
    if (selectedCategory.value == '' || selectedCategory.value.isEmpty) {
      TaskInfo.showSnackBar("Enter a Category ");
      isLoadingCreateTask.value = false;
      return;
    }

    try {
      String monthName = DateFormat.MMMM().format(selectedDate.value!);
      String timeString = selectedTime.value.toString();
      String formattedTime = timeString.replaceAll(RegExp(r'[^\d:]'), '');

      Map<String, dynamic>? data = {
        'title': title.text,
        'notes': notes.text,
        'date': selectedDate.value,
        'time': formattedTime,
        'priority': selectedPriority.value,
        'category': selectedCategory.value,
        'is_active': true
      };
      final firestore = await repository.prosesCreateTask(
        data,
        monthName,
      );
      if (firestore.result == FirestoreResultType.success) {
        TaskInfo.showSnackBar("${firestore.meessage}");
        await handleGetMonthlyTask(
          selectedMonth.value,
          selectedDay.value.toString(),
        );
      } else if (firestore.result == FirestoreResultType.failure) {
        TaskInfo.showSnackBar("${firestore.meessage}");
      }
    } finally {
      resetField();
      isLoadingCreateTask.value = false;
    }
  }

  Future<void> handleGetMonthlyTask(String monthly, String date) async {
    isLoadingGetMonthlyTask.value = true;
    try {
      final firestore = await repository.prosesGetMonthlyTask(
        monthly,
        date,
      );
      if (firestore.result == FirestoreResultType.success) {
        List<ScheduleBaseEntity>? entity = firestore.data;

        if (entity != null || entity!.isNotEmpty) {
          monthlyTask = entity.map((scheduleEntity) {
            return ScheduleViewModel.fromEntity(scheduleEntity);
          }).toList();
        }
      } else if (firestore.result == FirestoreResultType.failure) {
        TaskLogger.logError("${firestore.meessage}");
      }
    } finally {
      isLoadingGetMonthlyTask.value = false;
    }
  }

  List<ScheduleBaseEntity> convertQuerySnapshotToList(
      QuerySnapshot querySnapshot) {
    return querySnapshot.docs.map((document) {
      final documentData = document.data() as Map<String, dynamic>;
      return ScheduleBaseEntity.fromFirestoreData(documentData);
    }).toList();
  }
}
