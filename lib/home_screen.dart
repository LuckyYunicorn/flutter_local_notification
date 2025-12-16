import 'package:flutter/material.dart';
import 'local_notification.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await LocalNotification.showNotification(
            id: 1,
            title: "Local Notification",
            body: "I am testing local notification",
          );
        },
        child: Icon(Icons.notifications),
      ),
    );
  }
}
