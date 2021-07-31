import 'package:equal_cash/api/api.dart';
import 'package:dio/dio.dart';
import 'package:equal_cash/models/api/user_activities.dart';
import 'package:retrofit/retrofit.dart';

import '../models/api/forgot_password.dart';
import '../models/api/login.dart';
import '../models/api/notifications.dart';
import '../models/api/registration.dart';
import 'repository.dart';

class ApiDio {
  final dio = Dio();
  late AuthClient client;

  ApiDio() {
// dio.options.headers["Demo-Header"] = "demo header";   // config your dio headers globally
    client = AuthClient(dio);
  }

  Future<HttpResponse<RegResponse>> register(RegParam param) =>
      client.register(param);

  Future<HttpResponse<Login>> login(LoginParam param) => client.login(param);

  Future<HttpResponse<ForgotPassword>> forgotPassword(String email) =>
      client.forgotPassword(email);

  Future<HttpResponse<NotificationResponse>> _getUserNotifications(
          String userId) =>
      client.getUserNotifications(userId);

  Future<UserActivities> getUserActivities(String userId) =>
      client.getUserActivities(userId).then((value) => value.data);

  Future<UserActivities> getUserActivitiesLimit(String userId) =>
      client.getUserActivitiesLimit(userId).then((value) => value.data);

  Future<Map<String, List<DataBean>>> getUserNotifications(String userId) =>
      _getUserNotifications(userId).then((value) {
        Map<String, List<DataBean>> notifications = {};
        var dataList = value.data.response?.data;
        print(dataList.toString());
        dataList?.forEach((details) {
          String notificationHeading = details.notificationHeading!;
          List<DataBean>? prevNotification = notifications[notificationHeading];
          if (prevNotification != null) {
            if (notifications.containsKey(notificationHeading)) {
              prevNotification.add(details);
              notifications[notificationHeading] = prevNotification;
            } else {
              notifications[notificationHeading] = [details];
            }
          } else {
            notifications[notificationHeading] = [details];
          }
        });

        //@Todo Just for debuging, you should remove the following on production
        notifications.forEach((String key, element) {
          print("$key:[\n ");
          element.forEach((element) {
            print("${element.toJson()}\n");
          });
          print("\n ]");
        });

        return notifications;
      });
}
