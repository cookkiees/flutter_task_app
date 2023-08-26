import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_app/app/theme/utils/my_colors.dart';
import 'package:task_app/app/theme/utils/my_strings.dart';
import '../authentication/models/user_base_view_model.dart';
import 'controllers/main_controller.dart';

class MainScreen extends GetView<MainController> {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    UserBaseViewModel? user = Get.arguments;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(user),
      body: Obx(
        () => IndexedStack(
          index: controller.selectedIndex.value,
          children: const [
            Center(child: Text('1')),
            Center(child: Text('2')),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
      floatingActionButton: _buildFloatingActionbutton(),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
    );
  }

  AppBar _buildAppBar(UserBaseViewModel? user) {
    return AppBar(
      backgroundColor: Colors.white,
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: user != null
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildUserViewData(user),
                  _buildActionButton(),
                ],
              )
            : Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildUserViewData(controller.userViewModel.value),
                    _buildActionButton(),
                  ],
                ),
              ),
      ),
    );
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
        CircleAvatar(
          radius: 22.0,
          backgroundColor: MyColors.darkPrimary,
          backgroundImage: const AssetImage(
            'assets/avatars/3.jpg',
          ),
          child: userview?.photoUrl != null
              ? CachedNetworkImage(
                  imageUrl: userview?.photoUrl ?? '',
                  placeholder: (context, url) => const SizedBox.shrink(),
                  errorWidget: (context, url, error) => const SizedBox.shrink(),
                )
              : null,
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

  Widget _buildFloatingActionbutton() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: 48,
        height: 48,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: MyColors.darkSecondary,
        ),
        child: FloatingActionButton(
          onPressed: () {},
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Obx(
      () => Theme(
        data: ThemeData(splashColor: Colors.transparent),
        child: SizedBox(
          height: 90,
          child: BottomNavigationBar(
            backgroundColor: Colors.white,
            elevation: 0,
            selectedItemColor: MyColors.darkPrimary,
            unselectedItemColor: Colors.grey,
            selectedLabelStyle: MyText.defaultStyle(fontSize: 13),
            unselectedLabelStyle: MyText.defaultStyle(fontSize: 13),
            type: BottomNavigationBarType.fixed,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home_filled),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.calendar_month),
                label: '',
              ),
            ],
            currentIndex: controller.selectedIndex.value,
            onTap: controller.changeTab,
          ),
        ),
      ),
    );
  }
}
