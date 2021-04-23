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
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Color.fromRGBO(121, 128, 235, 1)),
        ),
        drawer: Drawer(),
        body: Container(
          color: Colors.white,
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
