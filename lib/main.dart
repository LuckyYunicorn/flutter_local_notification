import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_notification/bloc/posts/post_bloc.dart';
import 'package:flutter_notification/investment/home_screen.dart';
import 'package:flutter_notification/notificaton/local_notification.dart';
import 'package:flutter_notification/posts/screen/post_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalNotification.localNotifications();
  runApp(const NotificationApp());
}

class NotificationApp extends StatelessWidget {
  const NotificationApp({super.key});

  @override
  Widget build(BuildContext context) {
    // return MaterialApp(debugShowCheckedModeBanner: false, home: HomeScreen());
    return MaterialApp(debugShowCheckedModeBanner: false, home: PostScreen());
  }
}
