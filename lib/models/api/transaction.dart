import 'package:json_annotation/json_annotation.dart';

part 'transaction.g.dart';

@JsonSerializable()
class OngoingTransResponse {
  OngoingResponseBean? response;

  OngoingTransResponse({this.response});

  factory OngoingTransResponse.fromJson(Map<String, dynamic> json) => _$OngoingTransResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OngoingTransResponseToJson(this);
}

@JsonSerializable()
class OngoingResponseBean {
  num? status;
  String? message;
  List<TransDataBean>? data;

  OngoingResponseBean({this.status, this.message, this.data});

  factory OngoingResponseBean.fromJson(Map<String, dynamic> json) => _$OngoingResponseBeanFromJson(json);

  Map<String, dynamic> toJson() => _$OngoingResponseBeanToJson(this);
}

@JsonSerializable()
class TransDataBean {
  String? unique_id;
  String? request_id;
  String? seller_id;
  String? buyer_id;
  String? rate;
  String? amount;
  String? currency_from;
  String? currency_to;
  String? status;
  num? amount_to_pay;
  String? time_frame;
  String? currency_from_flag;
  String? currency_to_flag;
  String? date;

  TransDataBean({this.unique_id, this.request_id, this.seller_id, this.buyer_id, this.rate, this.amount, this.currency_from, this.currency_to, this.status, this.amount_to_pay, this.time_frame, this.currency_from_flag, this.currency_to_flag, this.date});

  factory TransDataBean.fromJson(Map<String, dynamic> json) => _$TransDataBeanFromJson(json);

  Map<String, dynamic> toJson() => _$TransDataBeanToJson(this);
}

