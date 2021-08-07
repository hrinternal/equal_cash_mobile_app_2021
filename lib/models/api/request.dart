import 'package:json_annotation/json_annotation.dart';

part 'request.g.dart';

@JsonSerializable()
class UserRequestResponse {
  UserRequestResponseBean? response;

  UserRequestResponse({this.response});

  factory UserRequestResponse.fromJson(Map<String, dynamic> json) => _$UserRequestResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserRequestResponseToJson(this);
}

@JsonSerializable()
class UserRequestResponseBean {
  num? status;
  String? message;
  List<UserRequestDataBean>? data;

  UserRequestResponseBean({this.status, this.message, this.data});

  factory UserRequestResponseBean.fromJson(Map<String, dynamic> json) => _$UserRequestResponseBeanFromJson(json);

  Map<String, dynamic> toJson() => _$UserRequestResponseBeanToJson(this);
}

@JsonSerializable()
class UserRequestDataBean {
  String? id;
  String? unique_id;
  String? user_id;
  String? amount;
  String? base_currency;
  String? quote_currency;
  String? time_frame;
  String? bank_name;
  String? account_name;
  String? account_number;
  String? rate;
  dynamic reference;
  String? status;
  String? date_created;
  num? no_of_offer;

  UserRequestDataBean({this.id, this.unique_id, this.user_id, this.amount, this.base_currency, this.quote_currency, this.time_frame, this.bank_name, this.account_name, this.account_number, this.rate, this.reference, this.status, this.date_created, this.no_of_offer});

  factory UserRequestDataBean.fromJson(Map<String, dynamic> json) => _$UserRequestDataBeanFromJson(json);

  Map<String, dynamic> toJson() => _$UserRequestDataBeanToJson(this);
}

@JsonSerializable()
class EditRequestParam {
  String? unique_id;
  String? amount;
  String? base_currency;
  String? quote_currency;
  String? time_frame;
  String? bank_name;
  String? account_number;
  String? account_name;
  String? rate;

  EditRequestParam({this.unique_id, this.amount, this.base_currency, this.quote_currency, this.time_frame, this.bank_name, this.account_number, this.account_name, this.rate});

  factory EditRequestParam.fromJson(Map<String, dynamic> json) => _$EditRequestParamFromJson(json);

  Map<String, dynamic> toJson() => _$EditRequestParamToJson(this);
}

@JsonSerializable()
class InitRequestParam {
  @JsonKey(name: "user_id")
  String? userId;
  String? amount;
  @JsonKey(name: "base_currency")
  String? baseCurrency;
  @JsonKey(name: "quote_currency")
  String? quoteCurrency;
  String? rate;
  String? reference;
  @JsonKey(name: "time_frame")
  String? timeFrame;

  InitRequestParam({this.userId, this.amount, this.baseCurrency, this.quoteCurrency, this.rate, this.reference, this.timeFrame});

  factory InitRequestParam.fromJson(Map<String, dynamic> json) => _$InitRequestParamFromJson(json);

  Map<String, dynamic> toJson() => _$InitRequestParamToJson(this);
}

