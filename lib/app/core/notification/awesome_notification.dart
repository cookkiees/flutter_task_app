// import 'dart:developer';

// import 'package:awesome_notifications/awesome_notifications.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class NotificationController extends ChangeNotifier {
//   static final NotificationController _instance =
//       NotificationController._internal();
//   factory NotificationController() {
//     return _instance;
//   }
//   NotificationController._internal();

//   String _firebaseToken = '';
//   String get firebaseToken => _firebaseToken;

//   String _nativeToken = '';
//   String get nativeToken => _nativeToken;

//   static ReceivedAction? initialAction;

//   static Future<void> initializeLocalNotifications() async {
//     await AwesomeNotifications().initialize(
//       null, //'resource://drawable/res_app_icon',//
//       [
//         NotificationChannel(
//             channelKey: 'alerts',
//             channelName: 'Alerts',
//             channelDescription: 'Notification tests as alerts',
//             playSound: true,
//             onlyAlertOnce: true,
//             groupAlertBehavior: GroupAlertBehavior.Children,
//             importance: NotificationImportance.High,
//             defaultPrivacy: NotificationPrivacy.Private,
//             defaultColor: Colors.deepPurple,
//             ledColor: Colors.deepPurple)
//       ],
//       debug: true,
//     );

//     // Get initial notification action is optional
//     initialAction = await AwesomeNotifications()
//         .getInitialNotificationAction(removeFromActionEvents: false);
//   }

//   // static Future<void> initializeRemoteNotifications(
//   //     {required bool debug}) async {
//   //   await Firebase.initializeApp(
//   //       // options: DefaultFirebaseOptions.currentPlatform,
//   //       );
//   //   await AwesomeNotificationsFcm().initialize(
//   //     onFcmSilentDataHandle: NotificationController.mySilentDataHandle,
//   //     onFcmTokenHandle: NotificationController.myFcmTokenHandle,
//   //     onNativeTokenHandle: NotificationController.myNativeTokenHandle,
//   //     licenseKeys: null,
//   //     debug: debug,
//   //   );
//   // }

//   static Future<void> getInitialNotificationAction() async {
//     ReceivedAction? receivedAction = await AwesomeNotifications()
//         .getInitialNotificationAction(removeFromActionEvents: true);
//     if (receivedAction == null) return;
//     // Fluttertoast.showToast(
//     //     msg: 'Notification action launched app: $receivedAction',
//     //   backgroundColor: Colors.deepPurple
//     // );
//     log('Notification action launched app: $receivedAction');
//   }

//   ///  *********************************************
//   ///     REMOTE NOTIFICATION EVENTS
//   ///  *********************************************
//   // @pragma("vm:entry-point")
//   // static Future<void> mySilentDataHandle(FcmSilentData silentData) async {
//   //   log('"SilentData": ${silentData.toString()}');
//   //   if (silentData.createdLifeCycle != NotificationLifeCycle.Foreground) {
//   //     log("bg");
//   //   } else {
//   //     log("FOREGROUND");
//   //   }
//   //   log('mySilentDataHandle received a FcmSilentData execution');
//   //   // await executeLongTaskInBackground();
//   // }

//   /// Use this method to detect when a new fcm token is received
//   @pragma("vm:entry-point")
//   static Future<void> myFcmTokenHandle(String token) async {
//     log('Firebase Token:"$token"');
//     _instance._firebaseToken = token;
//     _instance.notifyListeners();
//   }

//   /// Use this method to detect when a new native token is received
//   @pragma("vm:entry-point")
//   static Future<void> myNativeTokenHandle(String token) async {
//     log('Native Token:"$token"');

//     _instance._nativeToken = token;
//     _instance.notifyListeners();
//   }

//   // static Future<String> requestFirebaseToken() async {
//   //   if (await AwesomeNotificationsFcm().isFirebaseAvailable) {
//   //     try {
//   //       return await AwesomeNotificationsFcm().requestFirebaseAppToken();
//   //     } catch (exception) {
//   //       log('$exception');
//   //     }
//   //   } else {
//   //     log('Firebase is not available on this project');
//   //   }
//   //   return '';
//   // }

//   static Future<void> startListeningNotificationEvents() async {
//     AwesomeNotifications().setListeners(
//       onActionReceivedMethod: onActionReceivedMethod,
//       onNotificationCreatedMethod: onNotificationCreatedMethod,
//       onNotificationDisplayedMethod: onNotificationDisplayedMethod,
//       onDismissActionReceivedMethod: onDismissActionReceivedMethod,
//     );
//   }

//   @pragma('vm:entry-point')
//   static Future<void> onActionReceivedMethod(
//       ReceivedAction receivedAction) async {
//     if (receivedAction.actionType == ActionType.SilentAction ||
//         receivedAction.actionType == ActionType.SilentBackgroundAction) {
//       log('Message sent via notification input: "${receivedAction.buttonKeyInput}"');
//       // await executeLongTaskInBackground();
//     } else {
//       // MyApp.navigatorKey.currentState?.pushNamedAndRemoveUntil(
//       //     '/notification-page',
//       //         (route) =>
//       //     (route.settings.name != '/notification-page') || route.isFirst,
//       //     arguments: receivedAction);
//     }
//   }

//   @pragma('vm:entry-point')
//   static Future<void> onNotificationCreatedMethod(
//       ReceivedNotification receivedNotification) async {
//     AwesomeNotifications().decrementGlobalBadgeCounter();
//     log('Di panggil jika notifikasi dibuat');
//   }

//   @pragma('vm:entry-point')
//   static Future<void> onNotificationDisplayedMethod(
//       ReceivedNotification receivedNotification) async {
//     AwesomeNotifications().incrementGlobalBadgeCounter();

//     log('Di panggil jika notifikasi muncul');
//   }

//   @pragma('vm:entry-point')
//   static Future<void> onDismissActionReceivedMethod(
//       ReceivedNotification receivedNotification) async {
//     AwesomeNotifications().decrementGlobalBadgeCounter();
//     log('Di panggil jika notifikasi dihapus');
//   }

//   static Future<bool> displayNotificationRationale() async {
//     bool userAuthorized = false;
//     await showDialog(
//       context: Get.context!,
//       builder: (BuildContext ctx) {
//         return AlertDialog(
//           title: Text('Get Notified!',
//               style: Theme.of(Get.context!).textTheme.titleLarge),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Row(
//                 children: [
//                   Expanded(
//                     child: Image.asset(
//                       'assets/animated-bell.gif',
//                       height: MediaQuery.of(Get.context!).size.height * 0.3,
//                       fit: BoxFit.fitWidth,
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 20),
//               const Text(
//                   'Allow Awesome Notifications to send you beautiful notifications!'),
//             ],
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(ctx).pop();
//               },
//               child: Text(
//                 'Deny',
//                 style: Theme.of(Get.context!)
//                     .textTheme
//                     .titleLarge
//                     ?.copyWith(color: Colors.red),
//               ),
//             ),
//             TextButton(
//               onPressed: () async {
//                 userAuthorized = true;
//                 Navigator.of(ctx).pop();
//               },
//               child: Text(
//                 'Allow',
//                 style: Theme.of(Get.context!)
//                     .textTheme
//                     .titleLarge
//                     ?.copyWith(color: Colors.deepPurple),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//     return userAuthorized &&
//         await AwesomeNotifications().requestPermissionToSendNotifications();
//   }

//   static Future<void> createNewNotification() async {
//     bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
//     if (!isAllowed) isAllowed = await displayNotificationRationale();
//     if (!isAllowed) return;

//     await AwesomeNotifications().createNotification(
//       content: NotificationContent(
//           id: DateTime.now().millisecondsSinceEpoch.remainder(100000),
//           channelKey: 'alerts',
//           title: 'Huston! The eagle has landed!',
//           body:
//               "A small step for a man, but a giant leap to Flutter's community!",
//           bigPicture: 'https://storage.googleapis.com/cms-storage-bucket/d406c736e7c4c57f5f61.png',
//           largeIcon: 'https://storage.googleapis.com/cms-storage-bucket/0dbfcc7a59cd1cf16282.png',
//           //'asset://assets/images/balloons-in-sky.jpg',
//           notificationLayout: NotificationLayout.BigPicture,
//           payload: {'notificationId': '1234567890'}),
//       actionButtons: [
//         NotificationActionButton(key: 'REDIRECT', label: 'Redirect'),
//         NotificationActionButton(
//           key: 'REPLY',
//           label: 'Reply Message',
//           requireInputText: true,
//           actionType: ActionType.SilentAction,
//         ),
//         NotificationActionButton(
//           key: 'DISMISS',
//           label: 'Dismiss',
//           actionType: ActionType.DismissAction,
//           isDangerousOption: true,
//         )
//       ],
//     );
//   }

//   static Future<void> scheduleNewNotification() async {
//     bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
//     if (!isAllowed) isAllowed = await displayNotificationRationale();
//     if (!isAllowed) return;

//     await AwesomeNotifications().createNotification(
//       content: NotificationContent(
//         id: -1, // -1 is replaced by a random number
//         channelKey: 'alerts',
//         title: "Huston! The eagle has landed!",
//         body:
//             "A small step for a man, but a giant leap to Flutter's community!",
//         bigPicture:
//             'https://storage.googleapis.com/cms-storage-bucket/d406c736e7c4c57f5f61.png',
//         largeIcon:
//             'https://storage.googleapis.com/cms-storage-bucket/0dbfcc7a59cd1cf16282.png',
//         //'asset://assets/images/balloons-in-sky.jpg',
//         notificationLayout: NotificationLayout.BigPicture,
//         payload: {'notificationId': '1234567890'},
//       ),
//       actionButtons: [
//         NotificationActionButton(key: 'REDIRECT', label: 'Redirect'),
//         NotificationActionButton(
//           key: 'DISMISS',
//           label: 'Dismiss',
//           actionType: ActionType.DismissAction,
//           isDangerousOption: true,
//         )
//       ],
//       schedule: NotificationCalendar.fromDate(
//         date: DateTime.now().add(
//           const Duration(seconds: 10),
//         ),
//       ),
//     );
//   }

//   static Future<void> resetBadgeCounter() async {
//     await AwesomeNotifications().resetGlobalBadge();
//   }

//   static Future<void> cancelNotifications() async {
//     await AwesomeNotifications().cancelAll();
//   }
// }
