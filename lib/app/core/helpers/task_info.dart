import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_app/app/theme/utils/my_colors.dart';
import 'package:task_app/app/theme/utils/my_strings.dart';

class TaskInfo {
  static void showSnackBar(String message) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(
        elevation: 0,
        backgroundColor: MyColors.orange,
        padding: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        behavior: SnackBarBehavior.floating,
        content: Text(
          '$message!!',
          style: MyText.defaultStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
