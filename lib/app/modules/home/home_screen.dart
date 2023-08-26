import 'package:cached_network_image/cached_network_image.dart';
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
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Row(
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
                  Icon(
                    Icons.search,
                    size: 24.0,
                    color: Colors.grey[400],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Obx(() {
      if (controller.selectedIndex.value == 0) {
        return AppBar(
          backgroundColor: Colors.white,
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
