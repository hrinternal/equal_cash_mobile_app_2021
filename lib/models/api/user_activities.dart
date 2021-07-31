import 'package:json_annotation/json_annotation.dart';

part 'user_activities.g.dart';

@JsonSerializable()
class UserActivities {
  ActResponseBean? response;

  UserActivities({this.response});

  factory UserActivities.fromJson(Map<String, dynamic> json) =>
      _$UserActivitiesFromJson(json);

  Map<String, dynamic> toJson() => _$UserActivitiesToJson(this);
}

@JsonSerializable()
class ActResponseBean {
  num? status;
  String? message;
  List<ActDataBean>? data;

  ActResponseBean({this.status, this.message, this.data});

  factory ActResponseBean.fromJson(Map<String, dynamic> json) =>
      _$ActResponseBeanFromJson(json);

  Map<String, dynamic> toJson() => _$ActResponseBeanToJson(this);
}

@JsonSerializable()
class ActDataBean {
  @JsonKey(name: "0")
  String? n0;
  String? id;
  @JsonKey(name: "1")
  String? n1;
  @JsonKey(name: "unique_id")
  String? uniqueId;
  @JsonKey(name: "2")
  String? n2;
  @JsonKey(name: "user_id")
  String? userId;
  @JsonKey(name: "3")
  String? n3;
  String? description;
  @JsonKey(name: "4")
  String? n4;
  @JsonKey(name: "date_created")
  String? dateCreated;

  ActDataBean(
      {this.n0,
      this.id,
      this.n1,
      this.uniqueId,
      this.n2,
      this.userId,
      this.n3,
      this.description,
      this.n4,
      this.dateCreated});

  factory ActDataBean.fromJson(Map<String, dynamic> json) =>
      _$ActDataBeanFromJson(json);

  Map<String, dynamic> toJson() => _$ActDataBeanToJson(this);
}
