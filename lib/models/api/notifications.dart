import 'package:json_annotation/json_annotation.dart';

part 'notifications.g.dart';

@JsonSerializable()
class NotificationResponse {
  ResponseBean? response;

  NotificationResponse({this.response});

  factory NotificationResponse.fromJson(Map<String, dynamic> json) =>
      _$NotificationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationResponseToJson(this);
}

@JsonSerializable()
class ResponseBean {
  num? status;
  String? message;
  List<DataBean>? data;

  ResponseBean({this.status, this.message, this.data});

  factory ResponseBean.fromJson(Map<String, dynamic> json) =>
      _$ResponseBeanFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseBeanToJson(this);
}

@JsonSerializable()
class DataBean {
  @JsonKey(name: "0")
  String? n0;
  String? id;
  @JsonKey(name: "1")
  String? n1;
  @JsonKey(name: "unique_id")
  String? uniqueId;
  @JsonKey(name: "2")
  String? n2;
  @JsonKey(name: "notification_type")
  String? notificationType;
  @JsonKey(name: "3")
  String? n3;
  @JsonKey(name: "user_id")
  String? userId;
  @JsonKey(name: "4")
  String? n4;
  @JsonKey(name: "notification_heading")
  String? notificationHeading;
  @JsonKey(name: "5")
  String? n5;
  String? notification;
  @JsonKey(name: "6")
  String? n6;
  String? status;
  @JsonKey(name: "7")
  String? n7;
  @JsonKey(name: "date_created")
  String? dateCreated;

  DataBean(
      {this.n0,
      this.id,
      this.n1,
      this.uniqueId,
      this.n2,
      this.notificationType,
      this.n3,
      this.userId,
      this.n4,
      this.notificationHeading,
      this.n5,
      this.notification,
      this.n6,
      this.status,
      this.n7,
      this.dateCreated});

  factory DataBean.fromJson(Map<String, dynamic> json) =>
      _$DataBeanFromJson(json);

  Map<String, dynamic> toJson() => _$DataBeanToJson(this);
  @override
  String toString() {
    // TODO: implement toString
    return notificationHeading??"Empty";
  }
}
