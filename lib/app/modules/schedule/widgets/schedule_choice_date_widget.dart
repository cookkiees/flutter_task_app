import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../components/my_global_container_widget.dart';
import '../../../theme/utils/my_colors.dart';
import '../../../theme/utils/my_strings.dart';
import '../controllers/schedule_controller.dart';

class ScheduleChoiceDateWidget extends GetView<ScheduleController> {
  const ScheduleChoiceDateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            'Date',
            style: MyText.defaultStyle(fontSize: 13),
          ),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            children: [
              Obx(() {
                return InkWell(
                  radius: 8,
                  onTap: () async {
                    await selectDate();
                  },
                  child: MyGlobalContainerWidget(
                    isSelected: controller.selectedDate.value != null,
                    color: controller.selectedDate.value != null
                        ? MyColors.blue
                        : Colors.white,
                    child: Text(
                      controller.selectedDate.value != null
                          ? DateFormat.yMMMMd('en_US')
                              .format(controller.selectedDate.value!)
                          : DateFormat.yMMMMd('en_US').format(
                              DateTime.now(),
                            ),
                      style: MyText.defaultStyle(
                        color: controller.selectedDate.value != null
                            ? Colors.white
                            : Colors.grey,
                        fontWeight: controller.selectedDate.value != null
                            ? FontWeight.w500
                            : null,
                      ),
                    ),
                  ),
                );
              }),
              const SizedBox(width: 16),
              Obx(
                () => InkWell(
                  onTap: () async {
                    await selectTime();
                  },
                  child: MyGlobalContainerWidget(
                    isSelected: controller.selectedTime.value != null,
                    color: controller.selectedTime.value != null
                        ? MyColors.orange
                        : Colors.white,
                    child: Text(
                      controller.selectedTime.value != null
                          ? controller.selectedTime.value!.format(context)
                          : TimeOfDay.now().format(context),
                      style: MyText.defaultStyle(
                        color: controller.selectedTime.value != null
                            ? Colors.white
                            : Colors.grey,
                        fontWeight: controller.selectedTime.value != null
                            ? FontWeight.w500
                            : null,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> selectTime() async {
    TimeOfDay? picked = await showTimePicker(
      context: Get.context!,
      initialTime: TimeOfDay.now(),
      initialEntryMode: TimePickerEntryMode.inputOnly,
    );

    if (picked != null && picked != controller.selectedTime.value) {
      controller.selectedTime.value = picked;
    }
  }

  Future<void> selectDate() async {
    DateTime? picked = await showCupertinoModalPopup(
      context: Get.context!,
      builder: (BuildContext context) {
        return Container(
          height: 300.0,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              )),
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.date,
            initialDateTime: controller.selectedDate.value,
            minimumDate: DateTime(2000),
            maximumDate: DateTime(2101),
            onDateTimeChanged: (DateTime newDate) {
              controller.selectedDate.value = newDate;
            },
          ),
        );
      },
    );

    if (picked != null && picked != controller.selectedDate.value) {
      controller.selectedDate.value = picked;
    }
  }
}
