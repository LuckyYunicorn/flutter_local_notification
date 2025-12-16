import 'package:flutter/material.dart';
import 'package:flutter_notification/home_screen.dart';
import 'package:flutter_notification/local_notification.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalNotification.localNotifications();
  runApp(const NotificationApp());
}

class NotificationApp extends StatelessWidget {
  const NotificationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: HomeScreen());
  }
}
