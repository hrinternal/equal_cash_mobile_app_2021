import 'package:json_annotation/json_annotation.dart';

part 'login.g.dart';

@JsonSerializable()
class Login {
  LoginResponse? response;

  Login({this.response});

  factory Login.fromJson(Map<String, dynamic> json) => _$LoginFromJson(json);

  Map<String, dynamic> toJson() => _$LoginToJson(this);
}

@JsonSerializable()
class LoginResponse {
  int? status;
  String? message;
  LoginData? data;

  LoginResponse({this.status, this.message, this.data});

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}

@JsonSerializable()
class LoginData {
  @JsonKey(name: "0")
  String? n0;
  String? id;
  @JsonKey(name: "1")
  String? n1;
  @JsonKey(name: "unique_id")
  String? uniqueId;
  @JsonKey(name: "2")
  String? n2;
  @JsonKey(name: "fullname")
  String? fullName;
  @JsonKey(name: "3")
  String? n3;
  String? username;
  @JsonKey(name: "4")
  String? n4;
  String? email;
  @JsonKey(name: "5")
  String? n5;
  String? phone;
  @JsonKey(name: "6")
  String? n6;
  String? address;
  @JsonKey(name: "7")
  String? n7;
  String? gender;
  @JsonKey(name: "8")
  String? n8;
  String? country;
  @JsonKey(name: "9")
  String? n9;
  String? currency;
  @JsonKey(name: "10")
  String? n10;
  String? password;
  @JsonKey(name: "11")
  String? n11;
  @JsonKey(name: "profile_pic")
  String? profilePic;
  @JsonKey(name: "12")
  String? n12;
  @JsonKey(name: "active_status")
  String? activeStatus;
  @JsonKey(name: "13")
  String? n13;
  @JsonKey(name: "date_created")
  String? dateCreated;

  LoginData(
      {this.n0,
      this.id,
      this.n1,
      this.uniqueId,
      this.n2,
      this.fullName,
      this.n3,
      this.username,
      this.n4,
      this.email,
      this.n5,
      this.phone,
      this.n6,
      this.address,
      this.n7,
      this.gender,
      this.n8,
      this.country,
      this.n9,
      this.currency,
      this.n10,
      this.password,
      this.n11,
      this.profilePic,
      this.n12,
      this.activeStatus,
      this.n13,
      this.dateCreated});

  factory LoginData.fromJson(Map<String, dynamic> json) =>
      _$LoginDataFromJson(json);

  Map<String, dynamic> toJson() => _$LoginDataToJson(this);
}

@JsonSerializable()
class LoginParam {
  String? email;
  String? password;

  LoginParam({this.email, this.password});

  factory LoginParam.fromJson(Map<String, dynamic> json) => _$LoginParamFromJson(json);

  Map<String, dynamic> toJson() => _$LoginParamToJson(this);
}

