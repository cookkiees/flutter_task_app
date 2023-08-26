import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_app/app/modules/home/controller/home_controller.dart';

import '../../theme/utils/my_colors.dart';
import '../../theme/utils/my_strings.dart';
import '../authentication/models/user_base_view_model.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, kToolbarHeight),
        child: _buildAppBar(),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: const Column(
            children: [],
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
                _buildUserViewData(controller.userViewModel.value),
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
          child: const Icon(
            Icons.notifications,
            color: Colors.grey,
          ),
        ),
        const SizedBox(width: 24),
        InkWell(
          onTap: () {},
          child: const Icon(
            Icons.settings,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildUserViewData(UserBaseViewModel? userview) {
    return Row(
      children: [
        const CircleAvatar(
          radius: 22.0,
          backgroundColor: MyColors.darkPrimary,
          backgroundImage: AssetImage(
            'assets/avatars/3.jpg',
          ),
          // child: userview?.photoUrl != null
          //     ? CachedNetworkImage(
          //         imageUrl: userview?.photoUrl ?? '',
          //         placeholder: (context, url) => const SizedBox.shrink(),
          //         errorWidget: (context, url, error) => const SizedBox.shrink(),
          //       )
          //     : null,
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
            Text(
              userview?.name ?? '',
              style: MyText.defaultStyle(
                color: MyColors.darkPrimary,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
