import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_app/app/modules/schedule/controllers/schedule_controller.dart';
import 'package:task_app/app/theme/utils/my_colors.dart';

import '../../../components/my_global_container_widget.dart';
import '../../../theme/utils/my_strings.dart';

class SchedulePriorityWidget extends GetView<ScheduleController> {
  const SchedulePriorityWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    List<String> priority = [
      'Low',
      'Medium',
      'High',
    ];
    List<Color> colors = [
      MyColors.blue,
      MyColors.orange,
      MyColors.red,
    ];
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Priority',
            style: MyText.defaultStyle(fontSize: 13),
          ),
          const SizedBox(height: 16),
          Obx(
            () => Row(
              children: priority.asMap().entries.map((entry) {
                final int index = entry.key;
                final String category = entry.value;
                final isSelected =
                    controller.selectedPriority.value == category;
                return Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: InkWell(
                    radius: 8,
                    onTap: () {
                      controller.setSelectedPriority(category);
                    },
                    child: MyGlobalContainerWidget(
                      isSelected: isSelected,
                      color: isSelected ? colors[index] : Colors.white,
                      child: Text(
                        category,
                        style: MyText.defaultStyle(
                          fontSize: 14,
                          color: isSelected ? Colors.white : Colors.grey,
                          fontWeight: isSelected ? FontWeight.w500 : null,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          )
        ],
      ),
    );
  }
}
