import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_app/app/core/notification/flutter_local_notification.dart';

import '../../../main.dart';
import '../../components/my_global_container_widget.dart';
import '../../theme/utils/my_colors.dart';
import '../../theme/utils/my_strings.dart';
import '../schedule/models/schedule_view_model.dart';
import 'controller/home_controller.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, kToolbarHeight),
        child: _buildAppBar(),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 24.0),
          child: Column(
            children: [
              _buildHeader(),
              const SizedBox(height: 16),
              Obx(
                () => controller.isEmptyTodayTask.value
                    ? SizedBox(
                        height: 200,
                        width: double.infinity,
                        child: Center(
                          child: Text(
                            'You have no Tasks for today !!',
                            style: MyText.defaultStyle(
                              fontSize: 14,
                              color: Colors.grey[500],
                            ),
                          ),
                        ),
                      )
                    : _buildMontlyTasks(),
              ),
              const SizedBox(height: 16),
              _buildHeaderUpcomingPlans(),
              Obx(() {
                if (controller.isEmptyUpComingTask.value) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 160),
                      Text(
                        'You have no Tasks for tomorrow !!',
                        style: MyText.defaultStyle(
                          fontSize: 14,
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  );
                } else if (controller.isLoadingUpComingTask.value) {
                  return const SizedBox.shrink();
                } else {
                  return Column(
                    children: List.generate(
                      controller.upcomingTask.length,
                      (index) {
                        if (controller.upcomingTask.isNotEmpty) {
                          final task = controller.upcomingTask[index];
                          return _buildUpComingTask(task!);
                        } else {
                          return const SizedBox.shrink();
                        }
                      },
                    ),
                  );
                }
              }),
            ],
          ),
        ),
      ),
    );
  }

  Padding _buildUpComingTask(ScheduleViewModel task) {
    Color colors;
    if (task.priority == 'Low') {
      colors = MyColors.blue;
    } else if (task.priority == 'Medium') {
      colors = MyColors.orange;
    } else {
      colors = MyColors.red;
    }
    final bulan = task.date.substring(0, 3);
    final tanggal = task.date.replaceAll(RegExp(r'[^0-9]'), '');
    var date = "$tanggal $bulan ";
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 24, bottom: 16),
            child: Text(
              task.time,
              style: MyText.defaultStyle(
                color: Colors.grey,
                fontSize: 10,
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Container(
              height: 100,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
              margin: const EdgeInsets.symmetric(horizontal: 24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(width: 1, color: colors),
              ),
              child: Row(
                children: [
                  MyGlobalContainerWidget(
                    height: 68,
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
                                  textAlign: TextAlign.center,
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
                              date,
                              style: MyText.defaultStyle(
                                fontSize: 10,
                                color: Colors.grey[400],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: InkWell(
                      onTap: () {},
                      child: const Icon(
                        Icons.more_horiz,
                        color: Colors.grey,
                        size: 20.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding _buildHeaderUpcomingPlans() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Upcoming Plans',
            style: MyText.defaultStyle(fontSize: 16),
          ),
          InkWell(
            onTap: () {},
            child: Text(
              'See all',
              style: MyText.titleStyle(color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }

  Obx _buildMontlyTasks() {
    return Obx(
      () {
        if (controller.isLoadingTodayTask.value) {
          return const SizedBox(height: 200);
        } else {
          return SizedBox(
            height: 210,
            child: Stack(
              children: [
                CarouselSlider.builder(
                  itemCount: controller.todayTask.length,
                  options: CarouselOptions(
                    height: 200,
                    autoPlay: false,
                    enlargeCenterPage: true,
                    viewportFraction: 0.8,
                    initialPage: 1,
                    enableInfiniteScroll: false,
                    autoPlayInterval: const Duration(seconds: 2),
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    onPageChanged: (index, carouselPageChangedReason) {
                      controller.currentIndex.value = index;
                    },
                  ),
                  itemBuilder:
                      (BuildContext context, int index, int realIndex) {
                    final todayTask = controller.todayTask[index];
                    return _buildContentItemBuilder(todayTask!);
                  },
                ),
                const SizedBox(height: 12),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: _buildDotsIndocatorTaskToday(),
                ),
              ],
            ),
          );
        }
      },
    );
  }

  Obx _buildDotsIndocatorTaskToday() {
    return Obx(
      () => controller.isLoadingTodayTask.value
          ? const SizedBox.shrink()
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                controller.todayTask.length,
                (index) {
                  final task = controller.todayTask[index];
                  Color colors;
                  if (task?.priority == 'Low') {
                    colors = MyColors.blue;
                  } else if (task?.priority == 'Medium') {
                    colors = MyColors.orange;
                  } else {
                    colors = MyColors.red;
                  }
                  return Container(
                    width: 4,
                    height: 4,
                    margin: const EdgeInsets.symmetric(horizontal: 6.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: controller.currentIndex.value == index
                          ? colors
                          : Colors.grey.shade400,
                    ),
                  );
                },
              ),
            ),
    );
  }

  Builder _buildContentItemBuilder(ScheduleViewModel task) {
    Color colors;
    if (task.priority == 'Low') {
      colors = MyColors.blue;
    } else if (task.priority == 'Medium') {
      colors = MyColors.orange;
    } else {
      colors = MyColors.red;
    }
    final bulan = task.date.substring(0, 3);
    final tanggal = task.date.replaceAll(RegExp(r'[^0-9]'), '');
    var date = "$tanggal $bulan ";
    DateTime now = DateTime.now();
    String timeString = task.time;
    List<String> timeParts = timeString.split(':');
    int hour = int.parse(timeParts[0]);
    int minute = int.parse(timeParts[1]);
    DateTime taskTime = DateTime(now.year, now.month, now.day, hour, minute);

    return Builder(
      builder: (BuildContext context) {
        return Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: colors.withOpacity(0.7),
            border: Border.all(
              color: colors.withOpacity(0.2),
              width: 5,
            ),
            boxShadow: [
              BoxShadow(
                color: colors.withOpacity(0.3),
                blurRadius: 5,
                spreadRadius: 2,
                offset: const Offset(0, 8),
              ),
              BoxShadow(
                color: colors.withOpacity(0.5),
                blurRadius: 5,
                offset: const Offset(0, 0),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: colors,
                          blurRadius: 5,
                          spreadRadius: 2,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Text(
                      task.category,
                      style: MyText.defaultStyle(
                        color: colors,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  if (taskTime.hour >= 6 && taskTime.hour < 18)
                    const Icon(
                      Icons.wb_sunny,
                      size: 20,
                      color: Colors.white,
                    )
                  else
                    Icon(
                      Icons.nights_stay,
                      size: 20,
                      color: Colors.white,
                      shadows: [
                        BoxShadow(
                          color: colors,
                          blurRadius: 5,
                          spreadRadius: 2,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    )
                ],
              ),
              Text(
                task.notes,
                style: MyText.defaultStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.calendar_month,
                        size: 18.0,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        date,
                        style: MyText.defaultStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.schedule,
                        size: 16.0,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        task.time,
                        style: MyText.defaultStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: SizedBox(
        height: 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'My Montly Task',
                  style: MyText.defaultStyle(fontSize: 16),
                ),
                Obx(
                  () => controller.isLoadingTodayTask.value
                      ? SizedBox.fromSize()
                      : Text(
                          '${controller.todayTask.length} Task for Today',
                          style: MyText.subtitleStyle(),
                        ),
                ),
              ],
            ),
            Row(
              children: [
                VerticalDivider(
                  color: Colors.grey[300],
                  indent: 4,
                  endIndent: 4,
                ),
                Icon(
                  Icons.search,
                  size: 24.0,
                  color: Colors.grey[400],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Obx(
      () {
        if (controller.selectedIndex.value == 0) {
          return AppBar(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            elevation: 0,
            title: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildUserViewData(),
                  _buildActionButton(),
                ],
              ),
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  Widget _buildActionButton() {
    return Row(
      children: [
        InkWell(
          onTap: () {
            // NotificationController.createNewNotification();s
            NotificationLocal.showBigTextNotification(
              title: 'Task App',
              body: 'Nothing to see here',
              plugin: flutterLocalNotificationsPlugin,
            );
          },
          child: Icon(
            Icons.notifications,
            color: Colors.grey[400],
            size: 22,
          ),
        ),
        const SizedBox(width: 24),
        PopupMenuButton<String>(
          color: Colors.white,
          surfaceTintColor: Colors.white,
          elevation: 0.5,
          onSelected: (value) {
            if (value == 'Settings') {
              return;
            } else if (value == 'Logout') {
              controller.signOut();
            }
          },
          itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem<String>(
                value: 'Settings',
                child: Text('Settings', style: MyText.headerStyle()),
              ),
              PopupMenuItem<String>(
                value: 'Logout',
                child: Text('Logout', style: MyText.headerStyle()),
              ),
            ];
          },
          child: Icon(
            Icons.settings,
            color: Colors.grey[400],
            size: 22,
          ),
        )
      ],
    );
  }

  Widget _buildUserViewData() {
    return Row(
      children: [
        Obx(
          () => controller.isLoadingUser.value
              ? const SizedBox.shrink()
              : CircleAvatar(
                  radius: 22.0,
                  backgroundColor: MyColors.blue,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Image.asset('assets/avatars/1.jpg')),
                ),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome back',
              style: MyText.defaultStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
            Obx(
              () => controller.isLoadingUser.value
                  ? const SizedBox.shrink()
                  : Text(
                      controller.userViewModel.value.name ?? '',
                      style: MyText.defaultStyle(
                        color: MyColors.darkPrimary,
                        fontSize: 14,
                      ),
                    ),
            ),
          ],
        ),
      ],
    );
  }
}
