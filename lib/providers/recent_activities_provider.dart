import 'dart:convert';

import 'package:equal_cash/models/response_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RecentActivitiesProvider with ChangeNotifier {
  Future recentActivitiesLimit() async {
    SharedPreferences savedId = await SharedPreferences.getInstance();

    final userId = savedId.getString("userId");

    final url =
        "https://peertopeer.staging.cloudware.ng/api/get_recent_activities_limit.php?user_id=$userId";

    final response = await http.post(
      Uri.parse(url),
    );

    final responseBody = jsonDecode(response.body);
    print("RESPONSE BODY $responseBody");
    print("RESPONSE Distinct ${responseBody['response']}");

    recentLimitActivities.addAll(responseBody['response']);

    // final activities = responseBody['response']['data'] as List;
    // print(activities);
  }

  // Future recentActivities() async {
  //   SharedPreferences savedId = await SharedPreferences.getInstance();

  //   final userId = savedId.getString("userId");

  //   final url =
  //       "https://peertopeer.staging.cloudware.ng/api/get_recent_activities_all.php?$userId";

  //   final response = await http.post(
  //     Uri.parse(url),
  //   );

  //   final responseBody = jsonDecode(response.body);
  //   print("RESPONSE BODY ALL $responseBody");
  //   print("RESPONSE Distinct ALL ${responseBody['response']}");
  // }
}
