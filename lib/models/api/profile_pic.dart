import 'package:json_annotation/json_annotation.dart';

part 'profile_pic.g.dart';

@JsonSerializable()
class ProfilePicResponse {
  ProfilePicResponseBean? response;

  ProfilePicResponse({this.response});

  factory ProfilePicResponse.fromJson(Map<String, dynamic> json) => _$ProfilePicResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProfilePicResponseToJson(this);
}

@JsonSerializable()
class ProfilePicResponseBean {
  num? status;
  String? message;
  ProfilePicDataBean? data;

  ProfilePicResponseBean({this.status, this.message, this.data});

  factory ProfilePicResponseBean.fromJson(Map<String, dynamic> json) => _$ProfilePicResponseBeanFromJson(json);

  Map<String, dynamic> toJson() => _$ProfilePicResponseBeanToJson(this);
}

@JsonSerializable()
class ProfilePicDataBean {
  @JsonKey(name: "profile_pic")
  String? profilePic;

  ProfilePicDataBean({this.profilePic});

  factory ProfilePicDataBean.fromJson(Map<String, dynamic> json) => _$ProfilePicDataBeanFromJson(json);

  Map<String, dynamic> toJson() => _$ProfilePicDataBeanToJson(this);
}

