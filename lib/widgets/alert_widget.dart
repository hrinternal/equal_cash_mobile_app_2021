import 'package:equal_cash/controllers/alert.dart';
import 'package:equal_cash/models/api/notifications.dart';
import 'package:equal_cash/api/repository.dart';
import 'package:flutter/material.dart';
import 'package:equal_cash/models/home_pager_model.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';

import '../pref.dart';

class AlertWidget extends StatefulWidget {
  @override
  _AlertWidgetState createState() => _AlertWidgetState();
}

class _AlertWidgetState extends State<AlertWidget> {
  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(7.0),
      child: Column(
        children: [
          Column(
            children: [
              ListTile(
                title: Text(
                  "Alerts",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 20),
                ),
                subtitle: Text(
                  "Be in the know",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      // color: Colors.black,
                      fontSize: 12),
                ),
                trailing: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Container(
                      height: 50,
                      width: 50,
                      child: Icon(
                        Icons.notifications,
                        color: Color.fromRGBO(14, 129, 59, 1),
                      ),
                    )),
              ),
            ],
          ),
          AlertListWidget(deviceHeight: deviceHeight),
          // OldAlert(deviceHeight: deviceHeight),
        ],
      ),
    );
  }
}

class OldAlert extends StatelessWidget {
  const OldAlert({
    Key? key,
    required this.deviceHeight,
  }) : super(key: key);

  final double deviceHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.amber,
      // height: 300,
      child: ListView(
        shrinkWrap: true,
        children: [
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
                    color: Color.fromRGBO(14, 129, 59, 1),
                    fontSize: deviceHeight < 700 ? 10 : 12,
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
                    fontSize: deviceHeight < 700 ? 10 : 12,
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
                    fontSize: deviceHeight < 700 ? 10 : 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AlertItem extends StatelessWidget {
  const AlertItem({
    Key? key,
    required this.deviceHeight,
    required this.title,
  }) : super(key: key);

  final double deviceHeight;
  final String title;

  String get newTitle {
    if (title == "Offer reject")
      return "Rejected Offer";
    else if (title == "Request")
      return "New sell request";
    else if (title == "Offer Counter" || title == "Offer counter")
      return "Offer Countered";
    else if (title == "Offer accept") return "Accepted Offer";
    return "Others";
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        Icons.send_outlined,
        color: Color.fromRGBO(36, 102, 180, 1),
      ),
      title: Text(
        newTitle,
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
              fontSize: deviceHeight < 700 ? 10 : 12,
            ),
          ),
        ],
      ),
    );
  }
}

class AlertListWidget extends StatelessWidget {
  final double deviceHeight;

  const AlertListWidget({
    Key? key,
    required this.deviceHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
        future: Settings.instance.userId!,
        builder: (context, snapshot) {
          var userId = snapshot.data!;
          return GetBuilder<AlertController>(
              init: AlertController(userId),
              builder: (controller) {
                var notifications = controller.notifications.entries.toList();
                if (notifications.isEmpty) {
                  return CircularProgressIndicator();
                } else {
                  // if (controller.hasData) {
                  return Column(
                    children: notifications
                        .map(
                          (data) => InkWell(
                            onTap: () => Get.snackbar("", data.value.join(",")),
                            child: Material(
                              child: AlertItem(
                                deviceHeight: deviceHeight,
                                title: data.key,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  );
                  // } else {
                  //   return Text("No Notifications");
                  // }
                }
              });
        });
  }
}
