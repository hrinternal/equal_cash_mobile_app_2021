import 'package:equal_cash/providers/auth_provider.dart';
import 'package:equal_cash/providers/recent_activities_provider.dart';
import 'package:equal_cash/screens/currency_sell_request_screen.dart';
import 'package:equal_cash/screens/save_profile_screen.dart';
import 'package:equal_cash/screens/settings_screen.dart';
import 'package:equal_cash/screens/update_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:equal_cash/models/home_pager_model.dart';
import 'package:provider/provider.dart';

class ProfileWidget extends StatefulWidget {
  @override
  _ProfileWidgetState createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  @override
  Widget build(BuildContext context) {
    final activities = Provider.of<AuthProvider>(context, listen: false);

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
                  trailing: FutureBuilder(
                    future: activities.getImage(),
                    // initialData: InitialData,
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Container(
                                decoration:
                                    BoxDecoration(border: Border.all(width: 2)),
                                height: 55,
                                width: 55,
                                child: Image.asset(
                                  "assets/images/loading1.png",
                                  // fit: BoxFit.cover,
                                  height: 20,
                                  width: 20,
                                )));
                      } else {
                        if (activities.getProfilePic == null) {
                          return ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Container(
                                decoration:
                                    BoxDecoration(border: Border.all(width: 2)),
                                height: 55,
                                width: 55,
                                child: Icon(
                                  Icons.person,
                                  color: Color.fromRGBO(14, 129, 59, 1),
                                ),
                              ));
                        } else {
                          return ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(width: 2)),
                                  height: 55,
                                  width: 55,
                                  child: Image.network(
                                    activities.getProfilePic,
                                    fit: BoxFit.cover,
                                  )));
                        }
                      }
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(SaveProfileScreen.routeName);
              },
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
              onTap: () => Navigator.of(context)
                  .pushNamed(CurrencySellRequestScreen.routeName),
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
              onTap: () =>
                  Navigator.of(context).pushNamed(SettingsScreen.routeName),
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
