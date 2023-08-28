import 'package:flutter/material.dart';
import 'package:task_app/app/components/my_global_container_widget.dart';
import 'package:task_app/app/modules/schedule/models/schedule_view_model.dart';
import 'package:task_app/app/theme/utils/my_strings.dart';

import '../theme/utils/my_colors.dart';

class MyGlobalCardWidget extends StatelessWidget {
  const MyGlobalCardWidget({
    super.key,
    required this.task,
  });

  final ScheduleViewModel task;

  @override
  Widget build(BuildContext context) {
    Color colors;
    if (task.priority == 'Low') {
      colors = MyColors.blue;
    } else if (task.priority == 'Medium') {
      colors = MyColors.orange;
    } else {
      colors = MyColors.red;
    }
    return SizedBox(
      width: double.infinity,
      child: Container(
        height: 70,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        margin: const EdgeInsets.only(left: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(width: 1, color: colors),
        ),
        child: Row(
          children: [
            MyGlobalContainerWidget(
              isSelected: true,
              color: colors,
              child: Text(
                'Active',
                style: MyText.subtitleStyle(
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          task.category.toUpperCase(),
                          style: MyText.defaultStyle(
                            color: Colors.grey[400],
                            fontSize: 12,
                          ),
                        ),
                        Flexible(
                          child: Text(
                            task.notes,
                            style: MyText.defaultStyle(
                              fontSize: 12,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_month,
                        size: 12,
                        color: colors,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        task.date,
                        style: MyText.defaultStyle(
                          fontSize: 10,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
