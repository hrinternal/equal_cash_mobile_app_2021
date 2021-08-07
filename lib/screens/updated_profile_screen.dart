import 'package:equal_cash/models/api/login.dart';
import 'package:equal_cash/pref.dart';
import 'package:equal_cash/screens/currency_sell_request_screen.dart';
import 'package:equal_cash/screens/home_screen.dart';
import 'package:equal_cash/screens/settings_screen.dart';
import 'package:equal_cash/widgets/profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdatedProfileScreen extends StatefulWidget {
  static const routeName = "updated";

  @override
  _UpdatedProfileScreenState createState() => _UpdatedProfileScreenState();
}

class _UpdatedProfileScreenState extends State<UpdatedProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Updated profile",
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
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder<LoginData?>(
              future: Settings.instance.user,
              builder: (context, snapshot) {
                var loginData = snapshot.data;
                return Column(
                  children: [
                    Column(
                      children: [
                        ListTile(
                          title: Text(
                            "Amia Ade",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 22),
                          ),
                          subtitle: Text(
                            "EqualCash ID ${loginData?.username ?? ""}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                // color: Colors.black,
                                fontSize: 12),
                          ),
                          trailing: ProfileImageWidget(
                            size: 60,
                          ),
                        )
                        //   }
                        // ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    //DOCUMENTS
                    UserData(loginData: loginData),
                    SizedBox(
                      height: 20,
                    ),
                    UserData1(),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      alignment: Alignment.centerLeft,
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "EMAIL",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 16),
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              loginData?.email ?? "",
                              style: TextStyle(
                                  // fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      width: double.maxFinite,
                      // margin: EdgeInsets.symmetric(horizontal: 20),
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)),
                        padding: EdgeInsets.symmetric(vertical: 13),
                        onPressed: () => Get.back(),
                        child: Text(
                          'Edit Profile',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        color: Theme.of(context).primaryColor,
                      ),
                    ),

                    SizedBox(
                      height: 50,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20),
                      alignment: Alignment.centerLeft,
                      width: double.maxFinite,
                      child: Text("ACTIONS",
                          style: TextStyle(fontSize: 14, color: Colors.black)),
                    ),
                    //LIST TILES
                    Container(
                      child: ListTile(
                        onTap: () => Navigator.of(context)
                            .pushNamed(CurrencySellRequestScreen.routeName),
                        leading: Icon(Icons.send_to_mobile,
                            color: Theme.of(context).primaryColor),
                        title: Text(
                          "Currency sell requests",
                          style: TextStyle(fontSize: 15, color: Colors.black),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios_rounded),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 30),
                      child: Divider(
                        thickness: 2,
                      ),
                    ),
                    Container(
                      child: ListTile(
                        onTap: () => Navigator.of(context)
                            .pushNamed(SettingsScreen.routeName),
                        leading: Icon(Icons.settings,
                            color: Theme.of(context).primaryColor),
                        title: Text(
                          "Settings",
                          style: TextStyle(fontSize: 15, color: Colors.black),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios_rounded),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 30),
                      child: Divider(
                        thickness: 2,
                      ),
                    ),
                  ],
                );
              }),
        ),
      ),
    );
  }
}

class UserData extends StatelessWidget {
  const UserData({
    Key? key,
    this.loginData,
  }) : super(key: key);
  final LoginData? loginData;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            margin: EdgeInsets.only(left: 20),
            // alignment: Alignment.centerLeft,
            width: MediaQuery.of(context).size.width * 0.35,
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "LIVES IN",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 16),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    loginData?.address ?? "",
                    style: TextStyle(
                        // fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
          Spacer(),
          Container(
            margin: EdgeInsets.only(right: 20),
            width: MediaQuery.of(context).size.width * 0.35,
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "PHONE NO.",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 16),
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: Text(
                    // "+234 8033 3333",
                    loginData?.phone ?? "",
                    style: TextStyle(
                        // fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 12),
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

class UserData1 extends StatelessWidget {
  const UserData1({
    Key? key,
    this.loginData,
  }) : super(key: key);
  final LoginData? loginData;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            margin: EdgeInsets.only(left: 20),
            width: MediaQuery.of(context).size.width * 0.35,
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "GENDER",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 16),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    // "FEMALE",
                    loginData?.gender ?? "",
                    style: TextStyle(
                        // fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
          Spacer(),
          Container(
            margin: EdgeInsets.only(right: 20),
            width: MediaQuery.of(context).size.width * 0.35,
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "MEMBER SINCE",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 16),
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: Text(
                    // "DECEMBER 25, 2020",
                    loginData?.dateCreated ?? "",
                    style: TextStyle(
                        // fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 12),
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
