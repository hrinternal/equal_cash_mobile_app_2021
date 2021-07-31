import 'package:equal_cash/models/api/forgot_password.dart';
import 'package:equal_cash/models/api/login.dart';
import 'package:equal_cash/models/api/notifications.dart';
import 'package:equal_cash/models/api/registration.dart';
import 'package:equal_cash/models/api/user_activities.dart';

import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'api.g.dart';

@RestApi(baseUrl: "http://peertopeer.staging.cloudware.ng")
abstract class AuthClient {
  factory AuthClient(Dio dio, {String baseUrl}) = _AuthClient;

  @POST("/api/registration.php")
  @FormUrlEncoded()
  Future<HttpResponse<RegResponse>> register(@Body() RegParam param);

  @POST("/api/authenticate.php")
  @FormUrlEncoded()
  Future<HttpResponse<Login>> login(@Body() LoginParam param);

  @POST("/api/forgot_password.php")
  @FormUrlEncoded()
  Future<HttpResponse<ForgotPassword>> forgotPassword(@Field() String email);

  @GET("/api/get_user_notifications.php")
  Future<HttpResponse<NotificationResponse>> getUserNotifications(@Query("user_id") String userId );


  @GET("/api/get_recent_activities_all.php")
  Future<HttpResponse<UserActivities>> getUserActivities(@Query("user_id") String userId );


  @GET("/api/get_recent_activities_limit.php")
  Future<HttpResponse<UserActivities>> getUserActivitiesLimit(@Query("user_id") String userId );



}
