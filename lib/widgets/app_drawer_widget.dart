import 'package:equal_cash/screens/activity_screen.dart';
import 'package:equal_cash/screens/all_requests.dart';
import 'package:equal_cash/screens/completed_transactions.dart';
import 'package:equal_cash/screens/login_screen.dart';
import 'package:equal_cash/screens/my_request_screen.dart';
import 'package:equal_cash/screens/pending_transactions.dart';
import 'package:equal_cash/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppDrawerWidget extends StatefulWidget {
  @override
  _AppDrawerWidgetState createState() => _AppDrawerWidgetState();
}

class _AppDrawerWidgetState extends State<AppDrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(child: Image.asset("assets/images/logo.png")),
          ListTile(
            onTap: () =>
                Navigator.of(context).pushNamed(MyRequestScreen.routeName),
            leading: Icon(
              Icons.request_page,
              color: Theme.of(context).primaryColor,
            ),
            title: Text(
              "My requests",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
          Divider(
            thickness: 1,
          ),
          ListTile(
            onTap: () =>
                Navigator.of(context).pushNamed(AllRequestScreen.routeName),
            leading: Icon(
              Icons.request_quote_rounded,
              color: Theme.of(context).primaryColor,
            ),
            title: Text(
              "All requests",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
          Divider(
            thickness: 1,
          ),
          ListTile(
            onTap: () =>
                Navigator.of(context).pushNamed(PendingTransaction.routeName),
            leading: Icon(
              Icons.pending,
              color: Theme.of(context).primaryColor,
            ),
            title: Text(
              "Pending",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
          Divider(
            thickness: 1,
          ),
          ListTile(
            onTap: () =>
                Navigator.of(context).pushNamed(CompletedTransaction.routeName),
            leading: Icon(
              Icons.done_all_rounded,
              color: Theme.of(context).primaryColor,
            ),
            title: Text(
              "Completed",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
          Divider(
            thickness: 1,
          ),
          ListTile(
            onTap: () => Get.toNamed(ActivityScreen.routeName),
            leading: Icon(
              Icons.recent_actors,
              color: Theme.of(context).primaryColor,
            ),
            title: Text(
              "Recent activities",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
          Divider(
            thickness: 1,
          ),
          ListTile(
            onTap: () =>
                Navigator.of(context).pushNamed(SettingsScreen.routeName),
            leading: Icon(
              Icons.settings,
              color: Theme.of(context).primaryColor,
            ),
            title: Text(
              "Settings",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
          Divider(
            thickness: 1,
          ),
          ListTile(
            onTap: () => Navigator.of(context)
                .pushReplacement(MaterialPageRoute(builder: (_) {
              return LoginScreen();
            })),
            leading: Icon(
              Icons.logout,
              color: Theme.of(context).primaryColor,
            ),
            title: Text(
              "Logout",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
