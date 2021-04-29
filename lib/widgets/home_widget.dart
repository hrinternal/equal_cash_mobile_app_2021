import 'package:equal_cash/models/response_model.dart';
import 'package:equal_cash/providers/recent_activities_provider.dart';
import 'package:flutter/material.dart';
import 'package:equal_cash/models/home_pager_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

class HomeWidget extends StatefulWidget {
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  int currentPage = 0;
  String fullname;
  Future<String> username() async {
    SharedPreferences username = await SharedPreferences.getInstance();

    fullname = username.getString("fullname");

    return fullname;
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;

    final activities =
        Provider.of<RecentActivitiesProvider>(context, listen: false);

    print("MY RECENT ACT $recentLimitActivities");
    List actList = recentLimitActivities['data'];

    print("ACT LIST $actList}");

    // final activitiesAll =
    //     Provider.of<RecentActivitiesProvider>(context).recentActivities();

    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            Column(
              children: [
                ListTile(
                  title: FutureBuilder(
                    future: username(),
                    // initialData: InitialData,
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      return Text(
                        "Welcome, ${snapshot.data}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 20),
                      );
                    },
                  ),

                  // title:
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

                child: FutureBuilder(
                  future: activities.recentActivitiesLimit(),
                  // initialData: InitialData,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container(
                        alignment: Alignment.center,
                        // color: Colors.amber,
                        height: MediaQuery.of(context).size.height * 0.4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(
                              strokeWidth: 5,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Loading Recent Activities",
                              style: TextStyle(
                                  color: Colors.blue[900],
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      );
                    } else {}
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: activities.getRecentLimitCount,
                      itemBuilder: (_, index) {
                        return recentLimitActivities.isEmpty
                            ? CircularProgressIndicator()
                            : ListTile(
                                leading: Icon(
                                  Icons.local_activity_rounded,
                                  color: Colors.black,
                                ),
                                title: Text(
                                  activities.getRecentLimit[index]
                                      ['description'],
                                  style: TextStyle(
                                      fontSize: deviceHeight < 700 ? 15 : 17,
                                      color: Color.fromRGBO(14, 129, 59, 1),
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(
                                  "Your last activity was at",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                ),
                                trailing: Text(
                                  activities.getRecentLimit[index]
                                      ['date_created'],
                                  style: TextStyle(
                                      color: Color.fromRGBO(121, 128, 235, 1),
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                              );
                      },
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
