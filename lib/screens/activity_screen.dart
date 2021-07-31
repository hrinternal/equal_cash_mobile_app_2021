import 'package:equal_cash/api/repository.dart';
import 'package:equal_cash/controllers/activities_controller.dart';
import 'package:equal_cash/models/api/user_activities.dart';
import 'package:equal_cash/widgets/home_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../pref.dart';

class ActivityScreen extends StatelessWidget {
  static const String routeName = "activities";

  const ActivityScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Activities"),
        ),
        body: Center(
          child: Container(
            child: FutureBuilder<String?>(
                future: Settings.instance.userId!,
                builder: (context, snapshot) {
                  var userId = snapshot.data!;
                  print("user id is $userId");
                  return GetBuilder<Activity2Controller>(
                      init: Activity2Controller(userId),
                      builder: (controller) {
                        var response2 = controller.activities.value.response;
                        List<ActDataBean>? activities = response2?.data ?? [];

                        var count = activities.length;
                        if (activities.isEmpty) {
                          return Center(child: CircularProgressIndicator());
                        } else {
                          return ActivityItem(
                              count: count,
                              activities: activities,
                              deviceHeight: Get.width);
                        }
                      });
                }),
          ),
        ));
  }
}
