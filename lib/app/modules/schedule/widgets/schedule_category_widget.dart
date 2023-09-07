import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_app/app/theme/utils/my_colors.dart';

import '../../../components/my_global_container_widget.dart';
import '../../../theme/utils/my_strings.dart';
import '../controllers/schedule_controller.dart';

class ScheduleCategoryWidget extends GetView<ScheduleController> {
  const ScheduleCategoryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var categories = [
      'Personal',
      'Study',
      'Working',
    ];
    List<Color> colors = [
      MyColors.blue,
      MyColors.orange,
      MyColors.red,
    ];
    return Padding(
      padding: const EdgeInsets.only(left: 24, bottom: 24, right: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Category',
            style: MyText.defaultStyle(fontSize: 13),
          ),
          const SizedBox(height: 16),
          Obx(
            () => Wrap(
              spacing: 16,
              runSpacing: 16,
              direction: Axis.horizontal,
              children: categories.asMap().entries.map((entry) {
                final int index = entry.key;
                final String category = entry.value;
                final isSelected =
                    controller.selectedCategory.value == category;
                return InkWell(
                  radius: 8,
                  onTap: () {
                    controller.setSelectedCategory(category);
                  },
                  child: MyGlobalContainerWidget(
                    isSelected: isSelected,
                    alignment: null,
                    color: isSelected ? colors[index] : Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        category,
                        style: MyText.defaultStyle(
                          fontSize: 14,
                          color: isSelected ? Colors.white : Colors.grey,
                          fontWeight:
                              isSelected ? FontWeight.w500 : FontWeight.normal,
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
