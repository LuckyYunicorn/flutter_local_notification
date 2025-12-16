import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

FlutterLocalNotificationsPlugin notificationsPlugin =
    FlutterLocalNotificationsPlugin();

class LocalNotification {
  static Future<void> localNotifications() async {
    AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    DarwinInitializationSettings iosSettings = DarwinInitializationSettings(
      requestBadgePermission: true,
      requestAlertPermission: true,
      requestSoundPermission: true,
    );

    InitializationSettings initializationSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    bool? isInitialized = await notificationsPlugin.initialize(
      initializationSettings,
    );
    await notificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.requestNotificationsPermission();
    if (kDebugMode) {
      // ANSI escape codes
      const String red = '\x1B[31m';
      const String green = '\x1B[32m';
      const String yellow = '\x1B[33m';
      const String reset = '\x1B[0m';

      if (isInitialized != null && isInitialized == true) {
        print('$green Local notifications initialized successfully.$reset');
      } else {
        print('$red Local notifications initialization failed.$reset');
      }
    }
  }

  static Future<void> showNotification({
    required int id,
    required String title,
    required String body,
  }) async {
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
          "my-channel",
          "my-channel",
          importance: Importance.max,
          priority: Priority.max,
        );
    DarwinNotificationDetails iosNotificationDetails =
        DarwinNotificationDetails();
    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: iosNotificationDetails,
    );
    await notificationsPlugin.show(id, title, body, notificationDetails);
  }
}
