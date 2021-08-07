import 'package:json_annotation/json_annotation.dart';

part 'profile.g.dart';

@JsonSerializable()
class ProfileResponse {
  ProfileResponseBean? response;

  ProfileResponse({this.response});

  factory ProfileResponse.fromJson(Map<String, dynamic> json) => _$ProfileResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileResponseToJson(this);
}

@JsonSerializable()
class ProfileResponseBean {
  num? status;
  String? message;

  ProfileResponseBean({this.status, this.message});

  factory ProfileResponseBean.fromJson(Map<String, dynamic> json) => _$ProfileResponseBeanFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileResponseBeanToJson(this);
}

