import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:task_app/app/core/helpers/task_logger.dart';
import 'package:task_app/app/core/local_storage/shared_preference.dart';
import 'package:task_app/app/core/services/firebase_binding.dart';
import 'package:task_app/app/theme/utils/my_colors.dart';
import 'app/core/notification/flutter_local_notification.dart';
import 'app/routes/app_pages.dart';
import 'app/routes/app_routes.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // await NotificationController.initializeLocalNotifications();
  // await NotificationController.getInitialNotificationAction();
  // await NotificationController.initializeRemoteNotifications(debug: true);

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

final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

class MyApp extends StatefulWidget {
  const MyApp({super.key, this.initialRoute});
  final String? initialRoute;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // NotificationController.startListeningNotificationEvents();
    // NotificationController.requestFirebaseToken();
    NotificationLocal.initilize(flutterLocalNotificationsPlugin);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: widget.initialRoute,
      defaultTransition: Transition.fade,
      initialBinding: FirebaseBinding(),
      getPages: AppPages.pages,
      theme: ThemeData(
        primaryColor: MyColors.blue,
      ),
    );
  }
}
