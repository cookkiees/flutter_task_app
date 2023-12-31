import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_app/app/modules/home/controller/home_controller.dart';
import 'package:task_app/app/routes/app_routes.dart';

import '../../theme/utils/my_colors.dart';
import '../../theme/utils/my_strings.dart';
import '../home/home_screen.dart';
import '../schedule/controllers/schedule_controller.dart';
import '../schedule/schedule_screen.dart';
import 'controllers/main_controller.dart';

class MainScreen extends GetView<MainController> {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final schedule = Get.find<ScheduleController>();
    final home = Get.find<HomeController>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(
        () => IndexedStack(
          index: controller.selectedIndex.value,
          children: const [
            HomeScreen(),
            ScheduleScreen(),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(schedule, home),
      floatingActionButton: _buildFloatingActionbutton(),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
    );
  }

  Widget _buildFloatingActionbutton() {
    return Container(
      height: 48,
      width: 48,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: MyColors.red.withOpacity(0.2),
            blurRadius: 5,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          ),
          BoxShadow(
            color: MyColors.red.withOpacity(0.2),
            blurRadius: 5,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: FloatingActionButton(
        onPressed: () {
          Get.toNamed(AppRoutes.scheduleCreate);
        },
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        backgroundColor: MyColors.red,
        highlightElevation: 1,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildBottomNavigationBar(
      ScheduleController schedule, HomeController home) {
    return Obx(
      () => Theme(
        data: ThemeData(splashColor: Colors.transparent),
        child: SizedBox(
          height: 80,
          child: BottomNavigationBar(
            backgroundColor: Colors.white,
            elevation: 0,
            selectedItemColor: MyColors.orange,
            unselectedItemColor: Colors.grey.shade300,
            selectedLabelStyle: MyText.defaultStyle(fontSize: 13),
            unselectedLabelStyle: MyText.defaultStyle(fontSize: 13),
            type: BottomNavigationBarType.fixed,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.face,
                  size: 26,
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.calendar_month),
                label: '',
              ),
            ],
            currentIndex: controller.selectedIndex.value,
            onTap: (index) {
              if (index == 0) {
                home.handleUpComingTask();
              }
              controller.changeTab(index);
              schedule.scrollToSelectedDay();
            },
          ),
        ),
      ),
    );
  }
  //dasdsadas
}
