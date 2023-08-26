import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_app/app/core/helpers/task_logger.dart';
import 'package:task_app/app/core/local_storage/shared_preference.dart';
import 'package:task_app/app/core/services/firebase_binding.dart';
import 'app/routes/app_pages.dart';
import 'app/routes/app_routes.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final initialRoute = await determineInitialRoute();
  runApp(MyApp(initialRoute: initialRoute));
}

Future<String> determineInitialRoute() async {
  String? accessToken = await SharedPref.getAccessTokenFrom();
  TaskLogger.logInfo("SIGN IN WITH : $accessToken");
  if (accessToken != null) {
    return AppRoutes.main;
  } else {
    return AppRoutes.signIn;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, this.initialRoute});
  final String? initialRoute;
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: initialRoute,
      defaultTransition: Transition.fade,
      initialBinding: FirebaseBinding(),
      getPages: AppPages.pages,
    );
  }
}
