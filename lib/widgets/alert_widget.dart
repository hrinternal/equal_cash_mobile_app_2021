import 'package:flutter/material.dart';
import 'package:equal_cash/models/home_pager_model.dart';

class AlertWidget extends StatefulWidget {
  @override
  _AlertWidgetState createState() => _AlertWidgetState();
}

class _AlertWidgetState extends State<AlertWidget> {
  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    return Container(
      child: Column(
        children: [
          ListTile(
            title: Text(
              "Alerts",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            ),
            subtitle: Text("Be in the know"),
            trailing: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: IconButton(
                onPressed: () {},
                icon: Icon(Icons.notifications_active),
              ),
            ),
          ),
          ListView(
            children: [
              ListTile(
                leading: Icon(
                  Icons.send_outlined,
                  color: Color.fromRGBO(36, 102, 180, 1),
                ),
                title: Text(
                  "New sell request",
                  style: TextStyle(
                      fontSize: deviceHeight < 700 ? 15 : 17,
                      color: Color.fromRGBO(14, 129, 59, 1),
                      fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  "\$300 USD - NGN Naira",
                  style: TextStyle(fontSize: deviceHeight < 700 ? 11 : 13),
                ),
                trailing: Column(
                  children: [
                    Icon(
                      Icons.more_vert,
                      color: Colors.black,
                    ),
                    Text(
                      "now",
                      style: TextStyle(
                        color: Color.fromRGBO(121, 128, 235, 1),
                        fontSize: deviceHeight < 700 ? 8 : 10,
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.check_circle_outline_sharp,
                  color: Color.fromRGBO(13, 131, 60, 1),
                ),
                title: Text(
                  "Accepted offer",
                  style: TextStyle(
                      fontSize: deviceHeight < 700 ? 15 : 17,
                      color: Color.fromRGBO(14, 129, 59, 1),
                      fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  "\$200 USD - NGN Naira",
                  style: TextStyle(fontSize: deviceHeight < 700 ? 11 : 13),
                ),
                trailing: Column(
                  children: [
                    Icon(
                      Icons.more_vert,
                      color: Colors.black,
                    ),
                    Text(
                      "now",
                      style: TextStyle(
                        color: Color.fromRGBO(173, 21, 25, 1),
                        fontSize: deviceHeight < 700 ? 8 : 10,
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.cancel_outlined,
                  color: Color.fromRGBO(173, 21, 35, 1),
                ),
                title: Text(
                  "Rejected offer",
                  style: TextStyle(
                      fontSize: deviceHeight < 700 ? 15 : 17,
                      color: Color.fromRGBO(14, 129, 59, 1),
                      fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  "\$300 USD - NGN Naira",
                  style: TextStyle(fontSize: deviceHeight < 700 ? 11 : 13),
                ),
                trailing: Column(
                  children: [
                    Icon(Icons.more_vert),
                    Text(
                      "now",
                      style: TextStyle(
                        color: Color.fromRGBO(121, 128, 235, 1),
                        fontSize: deviceHeight < 700 ? 8 : 10,
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.delete_forever_outlined,
                  color: Color.fromRGBO(36, 102, 180, 1),
                ),
                title: Text(
                  "Deleted request",
                  style: TextStyle(
                      fontSize: deviceHeight < 700 ? 15 : 17,
                      color: Color.fromRGBO(14, 129, 59, 1),
                      fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  "\$300 USD - NGN Naira",
                  style: TextStyle(fontSize: deviceHeight < 700 ? 11 : 13),
                ),
                trailing: Column(
                  children: [
                    Icon(Icons.more_vert),
                    Text(
                      "now",
                      style: TextStyle(
                        color: Color.fromRGBO(121, 128, 235, 1),
                        fontSize: deviceHeight < 700 ? 8 : 10,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
