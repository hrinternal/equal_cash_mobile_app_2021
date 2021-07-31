import 'package:equal_cash/api/dio.dart';
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

  Future<Map<String, List<DataBean>>> getUserNotifications(String userId) =>
      dio.getUserNotifications(userId);

  Future<UserActivities?> getUserActivities(String userId) =>
      dio.getUserActivities(userId);

  Future<UserActivities?> getUserActivitiesLimit(String userId) {
    return dio.getUserActivitiesLimit(userId);
  }
}
