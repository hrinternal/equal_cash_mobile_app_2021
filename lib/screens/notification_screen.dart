import 'package:equal_cash/screens/home_screen.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  static const routeName = "notification";
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Notifications",
          style: TextStyle(fontSize: 17),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.home_rounded),
            onPressed: () =>
                Navigator.of(context).pushNamed(HomeScreen.routeName),
          ),
        ],
      ),
      body: Container(
          child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 16,
        ),
        child: Column(
          children: [
            ListTile(
                title: Text("Push notifications"),
                subtitle: Text(
                    "Get push notifications when there's an event in your account"),
                trailing: IconButton(
                    icon: Icon(
                      Icons.toggle_off_outlined,
                    ),
                    onPressed: () {})),
            ListTile(
                title: Text("Email notifications"),
                subtitle: Text(
                    "Get email notifications when you perform a transaction"),
                trailing: IconButton(
                    icon: Icon(
                      Icons.toggle_off_outlined,
                    ),
                    onPressed: () {}))
          ],
        ),
      )),
    );
  }
}
