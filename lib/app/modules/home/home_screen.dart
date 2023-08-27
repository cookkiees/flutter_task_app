import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../theme/utils/my_colors.dart';
import '../../theme/utils/my_strings.dart';
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
              _buildMontlyTasks(),
              const SizedBox(height: 16),
              _buildHeaderUpcomingPlans(),
              ...List.generate(3, (index) {
                return _buildUpcomingPlans();
              }),
            ],
          ),
        ),
      ),
    );
  }

  Padding _buildUpcomingPlans() {
    return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: Container(
        width: double.infinity,
        height: 110,
        margin: const EdgeInsets.symmetric(horizontal: 24),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Flexible(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 22,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: MyColors.blue.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 2,
              child: Container(
                margin: const EdgeInsets.only(top: 14, bottom: 14, right: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'WORKING',
                          style: MyText.subtitleStyle(
                            color: Colors.grey,
                          ),
                        ),
                        Icon(
                          Icons.more_horiz,
                          size: 18,
                          color: Colors.grey[400],
                        ),
                      ],
                    ),
                    Text(
                      'Meeting for new firm web app',
                      style: MyText.titleStyle(),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_month,
                          size: 14,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '24 April',
                          style: MyText.defaultStyle(
                            color: Colors.grey,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
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

  SizedBox _buildMontlyTasks() {
    return SizedBox(
      height: 210,
      child: CarouselSlider.builder(
        itemCount: 3,
        options: CarouselOptions(
          height: 180,
          autoPlay: false,
          enlargeCenterPage: true,
          viewportFraction: 0.8,
          autoPlayInterval: const Duration(seconds: 2),
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
        ),
        itemBuilder: (BuildContext context, int index, int realIndex) {
          return _buildContentItemBuilder();
        },
      ),
    );
  }

  Builder _buildContentItemBuilder() {
    return Builder(
      builder: (BuildContext context) {
        return Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                MyColors.blue.withOpacity(0.4),
                MyColors.blue.withOpacity(0.2),
                MyColors.blue.withOpacity(0.2),
                MyColors.blue.withOpacity(0.4),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: MyColors.blue.withOpacity(1),
              width: 0.5,
            ),
            boxShadow: [
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
                Text(
                  '0 Task for this mounth',
                  style: MyText.subtitleStyle(),
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
    return Obx(() {
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
    });
  }

  Widget _buildActionButton() {
    return Row(
      children: [
        InkWell(
          onTap: () {},
          child: Icon(
            Icons.notifications,
            color: Colors.grey[400],
            size: 22,
          ),
        ),
        const SizedBox(width: 24),
        InkWell(
          onTap: () {},
          child: Icon(
            Icons.settings,
            color: Colors.grey[400],
            size: 22,
          ),
        ),
      ],
    );
  }

  Widget _buildUserViewData() {
    // final image = controller.userViewModel.value?.photoUrl;
    return Row(
      children: [
        Obx(
          () => controller.isLoadingUser.value
              ? const SizedBox.shrink()
              : const CircleAvatar(
                  radius: 22.0,
                  backgroundColor: MyColors.darkPrimary,
                  backgroundImage: AssetImage(
                    'assets/avatars/1.jpg',
                  ),
                  // child: controller.userViewModel.value!.photoUrl != null
                  //     ? CachedNetworkImage(
                  //         imageUrl: image ?? '',
                  //         placeholder: (context, url) =>
                  //             const SizedBox.shrink(),
                  //         errorWidget: (context, url, error) =>
                  //             const SizedBox.shrink(),
                  //       )
                  //     : null,
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
                      controller.userViewModel.value?.name ?? '',
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
