import 'dart:io';

import 'package:equal_cash/api/api.dart';
import 'package:dio/dio.dart';
import 'package:equal_cash/models/api/offer.dart';
import 'package:equal_cash/models/api/profile.dart';
import 'package:equal_cash/models/api/profile_pic.dart';
import 'package:equal_cash/models/api/request.dart';
import 'package:equal_cash/models/api/transaction.dart';
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

  Future<NotificationResponse> getUserNotifications(String userId) =>
      client.getUserNotifications(userId).then((value) => value.data);

  Future<UserActivities> getUserActivities(String userId) =>
      client.getUserActivities(userId).then((value) => value.data);

  Future<ProfilePicResponse> getUserProfilePic(String userId) =>
      client.getUserProfilePic(userId).then((value) => value.data);

  Future<UserActivities> getUserActivitiesLimit(String userId) =>
      client.getUserActivitiesLimit(userId).then((value) => value.data);

  Future<ProfileResponse> updateProfile(gender, userId, address) =>
      client.updateProfile(gender, userId, address).then((value) => value.data);

  Future<ProfileResponse> initiateRequest(InitRequestParam param) =>
      client.initiateRequest(param).then((value) => value.data);

  Future<UserRequestResponse> getUserRequest(String userId) =>
      client.getUserRequest(userId);

  Future<ProfileResponse> acceptOfferSeller(AcceptOfferParam param) =>
      client.acceptOfferSeller(param);

  Future<ProfileResponse> counterOfferBuyer(CounterBuyerOffer param) =>
      client.counterOfferBuyer(param);

  Future<ProfileResponse> editRequest(@Body() EditRequestParam param) =>
      client.editRequest(param);

  Future<ProfileResponse> deleteRequest(String userId, String uniqueId) =>
      client.deleteRequest(userId, uniqueId);

  Future<OngoingTransResponse> getPendingTransaction(
          String userId) =>
      client.getPendingTransaction(userId).then((value) => value.data);

  Future<OngoingTransResponse> getCompletedTransaction(
          String userId) =>
      client.getCompletedTransaction(userId).then((value) => value.data);

  Future<ProfileResponse> updateProfileOld(
          gender, userId, address, String imagePath) =>
      client.updateProfile(gender, userId, address).then((value) {
        if (imagePath.isNotEmpty)
          return _updateProfilePic(userId, File(imagePath))
              .then((value) => value.data);
        else
          return value.data;
      });

  Future<HttpResponse<ProfileResponse>> _updateProfilePic(
          userId, File imageFile) =>
      client.updateProfilePic(userId, imageFile);

  Future<Map<String, List<DataBean>>> getUserNotificationsMap(String userId) =>
      getUserNotifications(userId).then((value) {
        Map<String, List<DataBean>> notifications = {};
        var dataList = value.response?.data;
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
