import 'package:flutter/material.dart';
import 'package:equal_cash/models/home_pager_model.dart';

class ProfileWidget extends StatefulWidget {
  @override
  _ProfileWidgetState createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    return Container(
        child: Column(
      children: [
        ListTile(
          title: Text(
            "Profile",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
          subtitle: Text("EqualCash ID ET8450"),
          trailing: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.person),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          height: 100,
          width: deviceWidth * 0.8,
          child: Stack(
            children: [
              ListTile(
                leading: Container(
                    width: 70,
                    child: Image.asset(
                      "assets/images/profile.png",
                      fit: BoxFit.cover,
                    )),
                title: Text(
                  "85% Complete",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  "Click to update",
                  style: TextStyle(
                    color: Color.fromRGBO(138, 90, 241, 1),
                  ),
                ),
              ),
              Positioned(
                  child: Container(
                height: 3,
                width: deviceWidth * 0.7,
                color: Color.fromRGBO(14, 129, 59, 1),
              ))
            ],
          ),
        ),
        ListTile(
          leading: Icon(
            Icons.screen_search_desktop,
            color: Color.fromRGBO(14, 129, 59, 1),
          ),
          title: Text("Currency sell requests"),
          trailing: IconButton(
              icon: Icon(Icons.arrow_forward_ios),
              onPressed: () {},
              color: Colors.black),
        ),
        ListTile(
          leading: Icon(
            Icons.settings,
            color: Color.fromRGBO(14, 129, 59, 1),
          ),
          title: Text("Seetings"),
          trailing: IconButton(
              icon: Icon(Icons.arrow_forward_ios),
              onPressed: () {},
              color: Colors.black),
        ),
        ListTile(
          leading: Icon(
            Icons.logout,
            color: Color.fromRGBO(14, 129, 59, 1),
          ),
          title: Text("Logout"),
          trailing: IconButton(
              icon: Icon(Icons.arrow_forward_ios),
              onPressed: () {},
              color: Colors.black),
        ),
      ],
    ));
  }
}
