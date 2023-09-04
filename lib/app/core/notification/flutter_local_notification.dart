import 'dart:developer';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationLocal {
  static void initilize(FlutterLocalNotificationsPlugin plugin) async {
    var initilizeAndroid =
        const AndroidInitializationSettings('mipmap/ic_launcher');
    var initilizeIOS = const DarwinInitializationSettings();
    var initilizeMACOS = const DarwinInitializationSettings();

    var initializationSettings = InitializationSettings(
        android: initilizeAndroid, iOS: initilizeIOS, macOS: initilizeMACOS);
    await plugin.initialize(initializationSettings);
  }

  static showBigTextNotification(
      {var id = 0,
      final String? title,
      final String? body,
      var playload,
      required FlutterLocalNotificationsPlugin plugin}) async {
    const androidNotificationDetails = AndroidNotificationDetails(
      'task',
      'channel_name',
      playSound: true,
      importance: Importance.max,
      priority: Priority.high,
    );

    const iOSNotificationDetails = DarwinNotificationDetails(
      presentSound: false,
    );

    var not = const NotificationDetails(
      android: androidNotificationDetails,
      iOS: iOSNotificationDetails,
    );
    await plugin.show(0, title, body, not);
  }

  @pragma('vm:entry-point')
  void notificationTapBackground(NotificationResponse notificationResponse) {
    // ignore: avoid_print
    log('notification(${notificationResponse.id}) action tapped: '
        '${notificationResponse.actionId} with'
        ' payload: ${notificationResponse.payload}');
    if (notificationResponse.input?.isNotEmpty ?? false) {
      // ignore: avoid_print
      log('notification action tapped with input: ${notificationResponse.input}');
    }
  }
}
