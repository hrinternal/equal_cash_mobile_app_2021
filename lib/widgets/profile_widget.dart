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
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Column(
              children: [
                ListTile(
                  title: Text(
                    "Profile",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 20),
                  ),
                  subtitle: Text(
                    "EqualCash ID ET8450",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        // color: Colors.black,
                        fontSize: 12),
                  ),
                  trailing: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Container(
                        decoration: BoxDecoration(border: Border.all(width: 2)),
                        height: 55,
                        width: 55,
                        child: Icon(
                          Icons.person,
                          color: Color.fromRGBO(14, 129, 59, 1),
                        ),
                      )),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {},
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(width: 1),
                    borderRadius: BorderRadius.circular(6)),
                height: 85,
                width: deviceWidth * 0.86,
                child: Stack(
                  children: [
                    ListTile(
                      leading: Image.asset(
                        "assets/images/profile.png",
                        fit: BoxFit.fitHeight,
                        height: double.maxFinite,
                      ),
                      title: Text(
                        "85% Complete",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      subtitle: RichText(
                        text: TextSpan(children: [
                          TextSpan(
                            text: "Click to update",
                            style: TextStyle(
                              color: Color.fromRGBO(138, 90, 241, 1),
                            ),
                          ),
                          TextSpan(
                            text: "  >",
                            style: TextStyle(
                              fontSize: 17,
                              color: Colors.black,
                            ),
                          ),
                        ]),
                        // "",
                        // style: TextStyle(
                        //   color: Color.fromRGBO(138, 90, 241, 1),
                        // ),
                      ),
                    ),
                    Positioned(
                        bottom: 0,
                        child: Container(
                          height: 3,
                          width: deviceWidth * 0.7,
                          color: Color.fromRGBO(14, 129, 59, 1),
                        ))
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            ListTile(
              leading: Icon(
                Icons.screen_search_desktop,
                color: Color.fromRGBO(14, 129, 59, 1),
              ),
              title: Text(
                "Currency sell requests",
                style: TextStyle(fontSize: 16),
              ),
              trailing: IconButton(
                  icon: Icon(Icons.arrow_forward_ios),
                  onPressed: () {},
                  color: Colors.black),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 2,
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.settings,
                color: Color.fromRGBO(14, 129, 59, 1),
              ),
              title: Text(
                "Settings",
                style: TextStyle(fontSize: 16),
              ),
              trailing: IconButton(
                  icon: Icon(Icons.arrow_forward_ios),
                  onPressed: () {},
                  color: Colors.black),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 2,
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.logout,
                color: Color.fromRGBO(14, 129, 59, 1),
              ),
              title: Text(
                "Logout",
                style: TextStyle(fontSize: 16),
              ),
              trailing: IconButton(
                  icon: Icon(Icons.arrow_forward_ios),
                  onPressed: () {},
                  color: Colors.black),
            ),
          ],
        ));
  }
}
