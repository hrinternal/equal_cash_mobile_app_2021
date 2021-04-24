import 'package:flutter/material.dart';
import 'package:equal_cash/models/home_pager_model.dart';

class HomeWidget extends StatefulWidget {
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  int currentPage = 0;
  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;

    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Column(
            children: [
              ListTile(
                title: Text(
                  "Welcome, Mia",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 20),
                ),
                subtitle: Text(
                  "You're ready to use Equal Cash",
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
                      child: Image.asset("assets/images/logo1.png"),
                    )),
              ),
            ],
          ),
          SizedBox(
            height: 17,
          ),
          Container(
            // color: Colors.grey,
            height: deviceHeight >= 700 ? 250 : 180,
            child: PageView.builder(
              itemBuilder: (_, index) {
                return Column(
                  children: [
                    Container(
                        height: deviceHeight < 700 ? 120 : 190,
                        child: Image.asset(
                          pagers[index].image,
                          fit: BoxFit.cover,
                        )),
                    SizedBox(
                      height: deviceHeight < 700 ? 6 : 10,
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: deviceWidth * 0.65,
                      child: Text(
                        pagers[index].description,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: deviceHeight < 700 ? 13 : 15),
                      ),
                    )
                  ],
                );
              },
              itemCount: pagers.length,
              onPageChanged: (page) {
                setState(() {
                  currentPage = page;
                });
              },
            ),
          ),
          SizedBox(
            height: 5,
          ),
          //
          //DOTS
          //
          Container(
            width: double.maxFinite,
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(pagers.length, (index) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  height: deviceHeight < 700 ? 7 : 10,
                  width: deviceHeight < 700 ? 7 : 10,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      100,
                    ),
                    color: index == currentPage
                        ? Color.fromRGBO(121, 128, 235, 1)
                        : Color.fromRGBO(196, 196, 196, 1),
                  ),
                );
              }),
            ),
          ),
          SizedBox(
            height: deviceHeight < 700 ? 35 : 35,
          ),
          //
          //ACTIVITIES
          //
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Text(
                  "Recent activities",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: deviceHeight < 700 ? 15 : 18),
                ),
                Spacer(),
                InkWell(
                    onTap: () {},
                    child: Text(
                      "View more",
                      style: TextStyle(
                          color: Color.fromRGBO(121, 128, 235, 1),
                          fontSize: deviceHeight < 700 ? 10 : 13),
                    )),
              ],
            ),
          ),
          SizedBox(
            height: deviceHeight < 700 ? 7 : 10,
          ),
          //
          //ACTIVITIES
          //
          SingleChildScrollView(
            child: Container(
              height: 176,
              // color: Colors.amber,
              child: ListView(
                children: [
                  ListTile(
                    leading: Icon(
                      Icons.person_add_outlined,
                      color: Colors.black,
                    ),
                    title: Text(
                      "Created an account",
                      style: TextStyle(
                          fontSize: deviceHeight < 700 ? 15 : 17,
                          color: Color.fromRGBO(14, 129, 59, 1),
                          fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      "You created an equal Cash account",
                      style: TextStyle(fontSize: deviceHeight < 700 ? 11 : 13),
                    ),
                    trailing: Text(
                      "12, Feb",
                      style: TextStyle(
                        color: Color.fromRGBO(121, 128, 235, 1),
                        fontSize: deviceHeight < 700 ? 11 : 13,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.edit_outlined,
                      color: Colors.black,
                    ),
                    title: Text(
                      "Updated your profile",
                      style: TextStyle(
                          fontSize: deviceHeight < 700 ? 15 : 17,
                          color: Color.fromRGBO(14, 129, 59, 1),
                          fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      "Profile is now 100% complete",
                      style: TextStyle(fontSize: deviceHeight < 700 ? 11 : 13),
                    ),
                    trailing: Text(
                      "14, Feb",
                      style: TextStyle(
                        color: Color.fromRGBO(121, 128, 235, 1),
                        fontSize: 13,
                      ),
                    ),
                  ),
                  deviceHeight >= 700
                      ? ListTile(
                          leading: Icon(
                            Icons.send_outlined,
                            color: Colors.black,
                          ),
                          title: Text(
                            "Sell request",
                            style: TextStyle(
                                fontSize: deviceHeight < 600 ? 13 : 16,
                                color: Color.fromRGBO(14, 129, 59, 1),
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            "You created a sell request - \$100 USD",
                            style: TextStyle(
                                fontSize: deviceHeight < 700 ? 11 : 13),
                          ),
                          trailing: Text(
                            "12, Feb",
                            style: TextStyle(
                              color: Color.fromRGBO(121, 128, 235, 1),
                              fontSize: 13,
                            ),
                          ),
                        )
                      : null,
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
