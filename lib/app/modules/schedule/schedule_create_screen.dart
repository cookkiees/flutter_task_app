import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_app/app/components/my_global_elevatedbutton_widget.dart';
import 'package:task_app/app/modules/home/controller/home_controller.dart';
import 'package:task_app/app/theme/utils/my_colors.dart';

import '../../components/my_global_textformfield_widget.dart';
import '../../core/helpers/task_loading.dart';
import '../../theme/utils/my_strings.dart';
import 'controllers/schedule_controller.dart';
import 'widgets/schedule_category_widget.dart';
import 'widgets/schedule_choice_date_widget.dart';
import 'widgets/schedule_priority_widget.dart';

class ScheduleCreateScreen extends GetView<ScheduleController> {
  const ScheduleCreateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final home = Get.find<HomeController>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: Text(
          'CREATE NEW TASK',
          style: MyText.defaultStyle(
            color: MyColors.blue,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Get.back();
            home.handleUpComingTask();
            home.handleTodayTask();
          },
          icon: Icon(
            Icons.arrow_back,
            size: 24.0,
            color: Colors.grey[400]!,
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: MyGlobalElevatedButtonWidget(
            side: BorderSide.none,
            backgroundColor: MyColors.blue,
            onPressed: () {
              controller.handleCraeteTask();
            },
            child: Obx(
              () => controller.isLoadingCreateTask.value
                  ? TaskLoading.button()
                  : Text(
                      'Create Task',
                      style: MyText.defaultStyle(
                        color: Colors.white,
                      ),
                    ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildHeader(),
                _buildFieldTitleAndDescription(),
                const ScheduleChoiceDateWidget(),
                const SchedulePriorityWidget(),
                const ScheduleCategoryWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding _buildHeader() {
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24, bottom: 32),
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: 'An opportunity to plan something great ! Create a new ',
              style: MyText.defaultStyle(
                color: MyColors.darkSecondary,
                fontSize: 16,
              ),
            ),
            TextSpan(
              text: 'TASK',
              style: MyText.defaultStyle(
                color: MyColors.blue,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            TextSpan(
              text: ' NOW.',
              style: MyText.defaultStyle(
                color: MyColors.red,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding _buildFieldTitleAndDescription() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Title & Notes',
            style: MyText.defaultStyle(fontSize: 13),
          ),
          const SizedBox(height: 24),
          MyGlobalTextFormFieldWidget(
            controller: controller.title,
            labelText: 'Title',
            hintText: 'Enter a title',
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 100,
            child: MyGlobalTextFormFieldWidget(
              expands: true,
              isCollapsed: true,
              isDense: true,
              controller: controller.notes,
              contentPadding: const EdgeInsets.all(14),
              constraints: const BoxConstraints(maxHeight: 100),
              labelText: 'Notes',
              hintText: 'Enter a Notes',
              helperText: '',
            ),
          ),
        ],
      ),
    );
  }
}
