import 'package:json_annotation/json_annotation.dart';

part 'offer.g.dart';


@JsonSerializable()
class CounterBuyerOffer {
  String? request_id;
  String? user_id;
  String? counter_time;
  String? counter_rate;
  String? counter_amount;

  CounterBuyerOffer({this.request_id, this.user_id, this.counter_time, this.counter_rate, this.counter_amount});

  factory CounterBuyerOffer.fromJson(Map<String, dynamic> json) => _$CounterBuyerOfferFromJson(json);

  Map<String, dynamic> toJson() => _$CounterBuyerOfferToJson(this);
}



@JsonSerializable()
class AcceptOfferParam {
  @JsonKey(name: "request_id")
  String? requestId;
  @JsonKey(name: "user_id")
  String? userId;
  @JsonKey(name: "bank_name")
  String? bankName;
  @JsonKey(name: "account_name")
  String? accountName;
  @JsonKey(name: "account_number")
  String? accountNumber;
  @JsonKey(name: "transaction_id")
  String? transactionId;

  AcceptOfferParam(
      {this.requestId,
      this.userId,
      this.bankName,
      this.accountName,
      this.accountNumber,
      this.transactionId});

  factory AcceptOfferParam.fromJson(Map<String, dynamic> json) =>
      _$AcceptOfferParamFromJson(json);

  Map<String, dynamic> toJson() => _$AcceptOfferParamToJson(this);
}
