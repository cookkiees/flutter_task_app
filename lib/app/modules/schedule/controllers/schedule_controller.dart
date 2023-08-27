import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

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

  @override
  void onInit() {
    super.onInit();
    scrollController = ScrollController();
  }

  void scrollToSelectedDay() {
    int selectedIndex = getDaysForSelectedMonth().indexOf(selectedDay.value);
    if (selectedIndex >= 0 && scrollController.hasClients) {
      Future.delayed(const Duration(milliseconds: 100), () {
        scrollController.jumpTo(selectedIndex * 45);
      });
    }
  }
}
