import 'package:equal_cash/api/repository.dart';
import 'package:equal_cash/controllers/activities_controller.dart';
import 'package:equal_cash/pref.dart';
import 'package:equal_cash/models/api/user_activities.dart';
import 'package:equal_cash/models/response_model.dart';
import 'package:equal_cash/providers/anonymous.dart';
import 'package:equal_cash/screens/activity_screen.dart';
import 'package:flutter/material.dart';
import 'package:equal_cash/models/home_pager_model.dart';
import 'package:get/get.dart';
import 'package:retrofit/retrofit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

class HomeWidget extends StatefulWidget {
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  int currentPage = 0;
  String? fullname;

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;

    print("MY RECENT ACT $recentLimitActivities");
    List actList = recentLimitActivities['data'];

    print("ACT LIST $actList}");

    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            Column(
              children: [
                ListTile(
                  title: FutureBuilder<String?>(
                    future: Settings.instance.userFullName,
                    // initialData: InitialData,
                    builder: (BuildContext context,
                        AsyncSnapshot<String?> snapshot) {
                      return Text(
                        "Welcome ${snapshot.data?.split(" ")[0] ?? ""}!",
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
                      onTap: () => Get.toNamed(ActivityScreen.routeName),
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
                child: FutureBuilder<String?>(
                    future: Settings.instance.userId,
                    builder: (context, snapshot) {
                      String userId = snapshot.data!;
                      print("user id is $userId");
                      return ActivitiesWidget(
                        deviceHeight: deviceHeight,
                        controller: ActivityController(userId, limit: true),
                      );
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ActivitiesWidget extends StatelessWidget {
  const ActivitiesWidget({
    Key? key,
    required this.deviceHeight,
    required this.controller,
  }) : super(key: key);

  final ActivityController controller;
  final double? deviceHeight;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ActivityController>(
        init: controller,
        builder: (controller) {
          var response2 = controller.activities.response;
          List<ActDataBean>? activities = response2?.data ?? [];

          var count = activities.length;
          if (activities.isEmpty) {
            return Center(child: CircularProgressIndicator());
          } else {
            return ActivityItem(
                count: count,
                activities: activities,
                deviceHeight: deviceHeight);
          }
        });
  }
}

class ActivityItem extends StatelessWidget {
  const ActivityItem({
    Key? key,
    required this.count,
    required this.activities,
    required this.deviceHeight,
  }) : super(key: key);

  final int count;
  final List<ActDataBean> activities;
  final double? deviceHeight;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: AlwaysScrollableScrollPhysics(),
      itemCount: count,
      itemBuilder: (_, index) {
        ActDataBean activity = activities[index];
        return activities.isEmpty
            ? ListTile(
                title: Text("Loading Empty Activities"),
                trailing: CircularProgressIndicator())
            : ListTile(
                leading: Icon(
                  Icons.local_activity_rounded,
                  color: Colors.black,
                ),
                title: Text(
                  activity.description!,
                  style: TextStyle(
                      fontSize: deviceHeight! < 700 ? 15 : 17,
                      color: Color.fromRGBO(14, 129, 59, 1),
                      fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  "@ ${activity.dateCreated}",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                ),
                trailing: Text(
                  '',
                  style: TextStyle(
                      color: Color.fromRGBO(121, 128, 235, 1),
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
              );
      },
    );
  }
}
