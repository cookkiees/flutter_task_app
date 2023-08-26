import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:task_app/app/theme/utils/my_colors.dart';
import 'package:task_app/app/theme/utils/my_strings.dart';

import 'controllers/schedule_controller.dart';

class ScheduleScreen extends GetView<ScheduleController> {
  const ScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            _buildDayListView(),
            _buildDailyTask()
          ],
        ),
      ),
    );
  }

  Expanded _buildDailyTask() {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 24,
                bottom: 24,
                top: 8,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '3 task for today !!',
                    style: MyText.subtitleStyle(),
                  ),
                  Text(
                    'Daily Task',
                    style: MyText.defaultStyle(fontSize: 24),
                  ),
                ],
              ),
            ),
            ListView.builder(
              itemCount: 1,
              shrinkWrap: true,
              padding: const EdgeInsets.only(left: 12, right: 24),
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                int hour = index ~/ 2;
                int minute = (index % 2) * 30;
                DateTime time = DateTime(0, 1, 1, hour, minute);
                String formattedTime = DateFormat.Hm().format(time);

                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 12, bottom: 12),
                      child: Text(
                        formattedTime,
                        style: MyText.defaultStyle(
                          color: MyColors.darkPrimary,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    const MyGlobalCardWidget()
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      elevation: 0,
      title: Padding(
        padding: const EdgeInsets.only(left: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildDropdownButton(),
            InkWell(
              onTap: () {},
              child: const Icon(
                Icons.more_vert,
                size: 20.0,
                color: Colors.grey,
              ),
            )
          ],
        ),
      ),
    );
  }

  Obx _buildDropdownButton() {
    return Obx(
      () => DropdownButton<String>(
        value: controller.selectedMonth.value,
        onChanged: (newValue) {
          controller.selectedMonth.value = newValue!;
        },
        underline: const SizedBox.shrink(),
        items: controller.months.map((month) {
          return DropdownMenuItem<String>(
            value: month,
            child: Text(
              month,
              style: MyText.defaultStyle(
                fontSize: controller.selectedMonth.value == month ? 18 : 14,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildDayListView() {
    return Obx(
      () => SizedBox(
        height: 80,
        child: ListView.builder(
          shrinkWrap: false,
          controller: controller.scrollController,
          itemCount: controller.getDaysForSelectedMonth().length,
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.only(left: 24),
          itemBuilder: (context, index) {
            int day = controller.getDaysForSelectedMonth()[index];
            int selectedMonthIndex =
                controller.months.indexOf(controller.selectedMonth.value) + 1;
            int dayOfWeek =
                DateTime(DateTime.now().year, selectedMonthIndex, day).weekday -
                    1;
            String weekday = controller.weekdays[dayOfWeek];
            return _buildContentItemBuilder(weekday, day);
          },
        ),
      ),
    );
  }

  Padding _buildContentItemBuilder(String weekday, int day) {
    return Padding(
      padding: const EdgeInsets.only(right: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            weekday,
            style: MyText.titleStyle(),
          ),
          const SizedBox(height: 12),
          InkWell(
            onTap: () {
              controller.setSelectedDay(day);
            },
            child: Obx(
              () => Container(
                width: 28,
                height: 28,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 0.5,
                    color: day == controller.selectedDay.value
                        ? Colors.transparent
                        : Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(4),
                  color: day == controller.selectedDay.value
                      ? MyColors.blue
                      : Colors.transparent,
                  boxShadow: day == controller.selectedDay.value
                      ? [
                          BoxShadow(
                            color: MyColors.blue.withOpacity(0.3),
                            blurRadius: 5,
                            spreadRadius: 2,
                            offset: const Offset(0, 8),
                          ),
                          BoxShadow(
                            color: MyColors.blue.withOpacity(0.5),
                            blurRadius: 5,
                            offset: const Offset(0, 0),
                          ),
                        ]
                      : [],
                ),
                child: Text(
                  day.toString(),
                  style: MyText.subtitleStyle(
                    fontWeight: day == controller.selectedDay.value
                        ? FontWeight.w600
                        : FontWeight.w400,
                    color: day == controller.selectedDay.value
                        ? Colors.white
                        : Colors.grey,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MyGlobalCardWidget extends StatelessWidget {
  const MyGlobalCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Container(
        height: 80,
        width: double.infinity,
        padding: EdgeInsets.zero,
        margin: const EdgeInsets.only(left: 12),
        decoration: BoxDecoration(
          color: MyColors.blue.withOpacity(0.2),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(width: 0.1, color: MyColors.blue),
        ),
      ),
    );
  }
}
