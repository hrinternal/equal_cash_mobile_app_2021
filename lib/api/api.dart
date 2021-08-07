import 'dart:io';

import 'package:equal_cash/models/api/forgot_password.dart';
import 'package:equal_cash/models/api/login.dart';
import 'package:equal_cash/models/api/notifications.dart';
import 'package:equal_cash/models/api/offer.dart';
import 'package:equal_cash/models/api/profile.dart';
import 'package:equal_cash/models/api/profile_pic.dart';
import 'package:equal_cash/models/api/registration.dart';
import 'package:equal_cash/models/api/request.dart';
import 'package:equal_cash/models/api/transaction.dart';
import 'package:equal_cash/models/api/user_activities.dart';
import 'package:flutter/cupertino.dart';

import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'api.g.dart';

const PIC_BASE_URL = "https://peertopeer.staging.cloudware.ng/api/";

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
  Future<HttpResponse<NotificationResponse>> getUserNotifications(
      @Query("user_id") String userId);

  @GET("/api/get_recent_activities_all.php")
  Future<HttpResponse<UserActivities>> getUserActivities(
      @Query("user_id") String userId);

  @GET("/api/get_recent_activities_limit.php")
  Future<HttpResponse<UserActivities>> getUserActivitiesLimit(
      @Query("user_id") String userId);

  @GET("/api/get_profile_pic.php")
  Future<HttpResponse<ProfilePicResponse>> getUserProfilePic(
      @Query("user_id") String userId);

  @POST("/api/update_profile.php")
  @FormUrlEncoded()
  Future<HttpResponse<ProfileResponse>> updateProfile(
      @Field() gender, @Field("user_id") userId, @Field() address);

  @POST("/api/upload_profile_pic.php")
  @FormUrlEncoded()
  @MultiPart()
  Future<HttpResponse<ProfileResponse>> updateProfilePic(
      @Field("user_id") userId, @Part() File imageFile);

  @POST("/api/initiate_request.php")
  @FormUrlEncoded()
  Future<HttpResponse<ProfileResponse>> initiateRequest(
      @Body() InitRequestParam param);

  @POST("/api/get_request_by_user_id.php")
  Future<UserRequestResponse> getUserRequest(@Query("user_id") String userId);

  @POST("/api/accept_offer_seller.php")
  @FormUrlEncoded()
  Future<ProfileResponse> acceptOfferSeller(@Body() AcceptOfferParam param);

  @POST("/api/counter_offer_buyer.php")
  @FormUrlEncoded()
  Future<ProfileResponse> counterOfferBuyer(@Body() CounterBuyerOffer param);

  @POST("/api/edit_request.php")
  @FormUrlEncoded()
  Future<ProfileResponse> editRequest(@Body() EditRequestParam param);

  @POST("/api/delete_request.php")
  @FormUrlEncoded()
  Future<ProfileResponse> deleteRequest(
    @Field("user_id") String userId,
    @Field("unique_id") String uniqueId,
  );

  @GET("/api/ongoing_transactions_buy.php")
  Future<HttpResponse<OngoingTransResponse>> getPendingTransaction(
      @Query("user_id") String userId);

  @GET("/api/completed_transactions_buy.php")
  Future<HttpResponse<OngoingTransResponse>> getCompletedTransaction(
      @Query("user_id") String userId);
}
