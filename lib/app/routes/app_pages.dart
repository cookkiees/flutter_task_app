import 'package:get/get.dart';
import 'package:task_app/app/modules/authentication/sign_in/controllers/sign_in_binding.dart';
import 'package:task_app/app/modules/authentication/sign_in/sign_in_screen.dart';
import 'package:task_app/app/modules/authentication/sign_up/controllers/sign_up_binding.dart';
import 'package:task_app/app/modules/authentication/sign_up/sign_up_screen.dart';
import 'package:task_app/app/modules/main/controllers/main_binding.dart';
import 'package:task_app/app/modules/main/main_screen.dart';

import '../modules/home/controller/home_binding.dart';
import '../modules/home/home_screen.dart';
import '../modules/schedule/controllers/schedule_binding.dart';
import '../modules/schedule/schedule_create_screen.dart';
import '../modules/schedule/schedule_screen.dart';
import 'app_routes.dart';

abstract class AppPages {
  static const initial = AppRoutes.initial;
  static final pages = [
    GetPage(
      name: AppRoutes.signIn,
      page: () => const SignInScreen(),
      binding: SignInBinding(),
    ),
    GetPage(
      name: AppRoutes.signUp,
      page: () => const SignUpScreen(),
      binding: SignUpBinding(),
      bindings: [SignInBinding()],
    ),
    GetPage(
      name: AppRoutes.main,
      page: () => const MainScreen(),
      binding: MainBinding(),
      bindings: [
        ScheduleBinding(),
        HomeBinding(),
      ],
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.schedule,
      page: () => const ScheduleScreen(),
      binding: ScheduleBinding(),
    ),
    GetPage(
      name: AppRoutes.scheduleCreate,
      page: () => const ScheduleCreateScreen(),
      binding: ScheduleBinding(),
    )
  ];
}
