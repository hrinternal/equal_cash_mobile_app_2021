import 'package:equal_cash/screens/change_password_screen.dart';
import 'package:equal_cash/screens/home_screen.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  static const routeName = "settings";
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Settings",
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
      body: Column(
        children: [
          Container(
            child: ListTile(
              onTap: () => Navigator.of(context)
                  .pushNamed(ChangePasswordScreen.routeName),
              // leading: Icon(Icons.send_to_mobile,
              //     color: Theme.of(context).primaryColor),
              leading: Text(
                "Change password",
                style: TextStyle(fontSize: 15, color: Colors.black),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios_rounded,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 18),
            child: Divider(
              thickness: 2,
            ),
          ),
          Container(
            child: ListTile(
              // leading:
              //     Icon(Icons.settings, color: Theme.of(context).primaryColor),
              leading: Text(
                "Change pin",
                style: TextStyle(fontSize: 15, color: Colors.black),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios_rounded,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 18),
            child: Divider(
              thickness: 2,
            ),
          ),
          Container(
            child: ListTile(
              // leading:
              //     Icon(Icons.logout, color: Theme.of(context).primaryColor),
              title: Text(
                "Notifications",
                style: TextStyle(fontSize: 15, color: Colors.black),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios_rounded,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
