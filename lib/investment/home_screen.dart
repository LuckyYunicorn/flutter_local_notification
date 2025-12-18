import 'package:flutter/material.dart';
import 'package:flutter_notification/api_methods/api.dart';
import 'package:flutter_notification/model/posts_model.dart';
import '../slivers/demo.dart';
import '../notificaton/local_notification.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  InvestmentModel? investmentModel = InvestmentModel();
  http.Client client = http.Client();
  ApiMethod apiMethod = ApiMethod();

  Future<void> getData() async {
    investmentModel = await apiMethod.getPosts(client: client);
  }

  @override
  void dispose() {
    client.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Error"));
          }
          return Center(
            child: Text(investmentModel?.message.toString() ?? "No data"),
          );
          // return ListView.builder(
          //   itemCount: posts.length,
          //   itemBuilder: (context, index) {
          //     Future.delayed(Duration(seconds: 5));
          //     LocalNotification.showNotification(
          //       id: posts[index].id ?? 0,
          //       title: "${posts[index].title}",
          //       body: "${posts[index].body}",
          //     );
          //     return ListTile(title: Text(posts[index].title ?? 'Lucky'));
          //   },
          // );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          client.close();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Demo()),
          );
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
