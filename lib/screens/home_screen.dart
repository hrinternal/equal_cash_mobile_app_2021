import 'package:equal_cash/models/home_pager_model.dart';
import "package:flutter/material.dart";

class HomeScreen extends StatefulWidget {
  static const String routeName = "home";
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentPage = 0;
  int bottomBarIndex = 0;

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(90),
          child: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(color: Color.fromRGBO(121, 128, 235, 1)),
            flexibleSpace: Container(
              // color: Colors.red,
              padding: EdgeInsets.only(left: 20, top: 15),
              alignment: Alignment.centerLeft,
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Welcome, Amia",
                      style: TextStyle(
                          fontSize: deviceHeight < 600 ? 18 : 22,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "You are ready to use Equal Cash",
                        style:
                            TextStyle(fontSize: deviceHeight < 600 ? 11 : 12),
                      ))
                ],
              ),
            ),
          ),
        ),
        endDrawer: Drawer(),
        body: Container(
          color: Colors.white,
          child: Column(
            children: [
              Container(
                // color: Colors.grey,
                height: deviceHeight >= 600 ? 230 : 180,
                child: PageView.builder(
                  itemBuilder: (_, index) {
                    return Column(
                      children: [
                        Container(
                            height: deviceHeight < 600 ? 120 : 180,
                            child: Image.asset(
                              pagers[index].image,
                              fit: BoxFit.cover,
                            )),
                        SizedBox(
                          height: deviceHeight < 600 ? 6 : 10,
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: deviceWidth * 0.65,
                          child: Text(
                            pagers[index].description,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: deviceHeight < 600 ? 12 : 15),
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
                      height: deviceHeight < 600 ? 7 : 10,
                      width: deviceHeight < 600 ? 7 : 10,
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
                height: deviceHeight < 600 ? 25 : 35,
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
                          fontSize: deviceHeight < 600 ? 15 : 18),
                    ),
                    Spacer(),
                    InkWell(
                        onTap: () {},
                        child: Text(
                          "View more",
                          style: TextStyle(
                              color: Color.fromRGBO(121, 128, 235, 1),
                              fontSize: deviceHeight < 600 ? 10 : 13),
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: deviceHeight < 600 ? 0 : 20,
              ),
              //
              //ACTIVITIES
              //
              Container(
                // color: Colors.amber,
                child: SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                        minHeight: deviceHeight < 600 ? 115 : 200,
                        maxHeight: deviceHeight < 600
                            ? deviceHeight * 0.29
                            : deviceHeight * 0.3),
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
                                fontSize: deviceHeight < 600 ? 13 : 16,
                                color: Color.fromRGBO(14, 129, 59, 1),
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            "You created an equal Cash account",
                            style: TextStyle(
                                fontSize: deviceHeight < 600 ? 11 : 13),
                          ),
                          trailing: Text(
                            "12, Feb",
                            style: TextStyle(
                              color: Color.fromRGBO(121, 128, 235, 1),
                              fontSize: deviceHeight < 600 ? 11 : 13,
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
                                fontSize: deviceHeight < 600 ? 13 : 16,
                                color: Color.fromRGBO(14, 129, 59, 1),
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            "Profile is now 100% complete",
                            style: TextStyle(
                                fontSize: deviceHeight < 600 ? 11 : 13),
                          ),
                          trailing: Text(
                            "14, Feb",
                            style: TextStyle(
                              color: Color.fromRGBO(121, 128, 235, 1),
                              fontSize: 13,
                            ),
                          ),
                        ),
                        ListTile(
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
                                fontSize: deviceHeight < 600 ? 11 : 13),
                          ),
                          trailing: Text(
                            "12, Feb",
                            style: TextStyle(
                              color: Color.fromRGBO(121, 128, 235, 1),
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.send_outlined), label: "Sell"),
            BottomNavigationBarItem(
                icon: Icon(Icons.notifications_none_rounded), label: "Alerts"),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_outline), label: "Profile"),
          ],
          onTap: (index) {
            setState(() {
              bottomBarIndex = index;
            });
          },
          unselectedFontSize: deviceHeight < 600 ? 13 : 14,
          currentIndex: bottomBarIndex,
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
          selectedFontSize: deviceHeight < 600 ? 14 : 16,
          unselectedItemColor: Colors.grey[700],
          selectedItemColor: Color.fromRGBO(14, 129, 59, 1),
          showUnselectedLabels: true,
        ),
      ),
    );
  }
}
