import 'package:json_annotation/json_annotation.dart';

part 'registration.g.dart';

@JsonSerializable()
class RegResponse {
  RegResponseBean? response;

  RegResponse({this.response});

  factory RegResponse.fromJson(Map<String, dynamic> json) =>
      _$RegResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RegResponseToJson(this);
}

@JsonSerializable()
class RegResponseBean {
  int? status;
  String? message;
  dynamic data;

  RegResponseBean({this.status, this.message, this.data});

  factory RegResponseBean.fromJson(Map<String, dynamic> json) =>
      _$RegResponseBeanFromJson(json);

  Map<String, dynamic> toJson() => _$RegResponseBeanToJson(this);
}

@JsonSerializable()
class RegParam {
  @JsonKey(name: "first_name")
  String? firstName;
  @JsonKey(name: "last_name")
  String? lastName;
  String? phone;
  String? email;
  String? password;
  String? country;
  @JsonKey(name: "confirm_password")
  String? confirmPassword;
  @JsonKey(name: "terms_condition")
  String? termsCondition;


  RegParam(
      {this.firstName,
      this.lastName,
      this.phone,
      this.email,
      this.password,
      this.country,
      this.confirmPassword,
      this.termsCondition});

  factory RegParam.fromJson(Map<String, dynamic> json) =>
      _$RegParamFromJson(json);

  Map<String, dynamic> toJson() => _$RegParamToJson(this);
}
