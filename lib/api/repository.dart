import 'package:equal_cash/api/dio.dart';
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

class ApiRepository {
  late ApiDio dio;

  ApiRepository() {
    dio = ApiDio();
  }

  Future<HttpResponse<RegResponse>> register(RegParam param) =>
      dio.register(param);

  Future<HttpResponse<Login>> login(LoginParam param) => dio.login(param);

  Future<HttpResponse<ForgotPassword>> forgotPassword(String email) =>
      dio.forgotPassword(email);

  Future<NotificationResponse>? getUserNotifications(String userId) =>
      dio.getUserNotifications(userId);

  Future<Map<String, List<DataBean>>>? getUserNotificationsMap(String userId) =>
      dio.getUserNotificationsMap(userId);

  Future<ProfilePicResponse>? getUserProfilePic(String userId) =>
      dio.getUserProfilePic(userId);

  Future<ProfileResponse>? updateProfile(gender, userId, address) =>
      dio.updateProfile(gender, userId, address);

  Future<UserActivities?> getUserActivities(String userId) =>
      dio.getUserActivities(userId);

  Future<UserActivities?> getUserActivitiesLimit(String userId) =>
      dio.getUserActivitiesLimit(userId);

  Future<ProfileResponse> initiateRequest(InitRequestParam param) =>
      dio.initiateRequest(param);

  Future<UserRequestResponse>? getUserRequest(String userId) =>
      dio.getUserRequest(userId);

  Future<ProfileResponse> acceptOfferSeller(AcceptOfferParam param) =>
      dio.acceptOfferSeller(param);

  Future<ProfileResponse> counterOfferBuyer(CounterBuyerOffer param) =>
      dio.counterOfferBuyer(param);

  Future<ProfileResponse> editRequest(@Body() EditRequestParam param) =>
      dio.editRequest(param);

  Future<ProfileResponse> deleteRequest(String userId, String uniqueId) =>
      dio.deleteRequest(userId, uniqueId);


  Future<OngoingTransResponse>? getPendingTransaction(
      String userId) =>
      dio.getPendingTransaction(userId);

  Future<OngoingTransResponse>? getCompletedTransaction(
      String userId) =>
      dio.getCompletedTransaction(userId);


}
