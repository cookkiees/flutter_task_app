import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_app/app/theme/utils/my_colors.dart';
import 'package:task_app/app/theme/utils/my_strings.dart';

import '../../components/my_global_card_widget.dart';
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
              padding: const EdgeInsets.only(left: 24, bottom: 24, top: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(
                    () {
                      if (controller.isLoadingGetMonthlyTask.value) {
                        return Text(
                          '0 task for today !!',
                          style: MyText.subtitleStyle(),
                        );
                      } else {
                        int tasksForSelectedDay = controller.monthlyTask
                            .where((task) =>
                                int.parse(task!.date.split(' ')[1]) ==
                                controller.selectedDay.value)
                            .length;
                        return Text(
                          '$tasksForSelectedDay task for today !!',
                          style: MyText.subtitleStyle(),
                        );
                      }
                    },
                  ),
                  Text(
                    'Daily Task',
                    style: MyText.defaultStyle(
                      fontSize: 24,
                      color: MyColors.darkSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Obx(() {
              if (controller.isLoadingGetMonthlyTask.value) {
                return const Center(
                  child: CupertinoActivityIndicator(
                    color: MyColors.blue,
                  ),
                );
              } else {
                return ListView.builder(
                  itemCount: controller.monthlyTask.length,
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(left: 12, right: 24),
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    int taskDay = int.parse(
                        controller.monthlyTask[index]!.date.split(' ')[1]);
                    bool taskMatchesSelectedDay =
                        taskDay == controller.selectedDay.value;

                    if (taskMatchesSelectedDay) {
                      final tasks = controller.monthlyTask
                          .where((task) => taskMatchesSelectedDay)
                          .toList();
                      tasks.sort((a, b) {
                        return a!.time.compareTo(b!.time);
                      });
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 12, bottom: 12),
                              child: Text(
                                tasks[index]?.time ?? '',
                                style: MyText.defaultStyle(
                                  color: Colors.grey,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                            MyGlobalCardWidget(
                              task: tasks[index]!,
                            )
                          ],
                        ),
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                );
              }
            })
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
        onChanged: (newValue) async {
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
            onTap: () async {
              controller.setSelectedDay(day);
              await controller.handleGetMonthlyTask(
                controller.selectedMonth.value,
                '$day',
              );
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
