import 'package:json_annotation/json_annotation.dart';

part 'forgot_password.g.dart';

@JsonSerializable()
class ForgotPassword {
  ForgotResponseBean? response;

  ForgotPassword({this.response});

  factory ForgotPassword.fromJson(Map<String, dynamic> json) => _$ForgotPasswordFromJson(json);

  Map<String, dynamic> toJson() => _$ForgotPasswordToJson(this);
}

@JsonSerializable()
class ForgotResponseBean {
  num? status;
  String? message;
  dynamic data;

  ForgotResponseBean({this.status, this.message, this.data});

  factory ForgotResponseBean.fromJson(Map<String, dynamic> json) => _$ForgotResponseBeanFromJson(json);

  Map<String, dynamic> toJson() => _$ForgotResponseBeanToJson(this);
}

