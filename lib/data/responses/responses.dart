import 'package:json_annotation/json_annotation.dart';
part 'responses.g.dart';

@JsonSerializable(createFactory: false, createToJson: false)
class BaseResponse {
  @JsonKey(name: "status")
  int? status;
  @JsonKey(name: "message")
  String? message;
}

@JsonSerializable()
class CustomerResponse {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "numOfNotifications")
  int? numOfNotifications;

  CustomerResponse(this.id, this.name, this.numOfNotifications);
  factory CustomerResponse.fromJson(Map<String, dynamic> json) =>
      _$CustomerResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerResponseToJson(this);
}

@JsonSerializable()
class ContactsResponse {
  @JsonKey(name: "email")
  String? email;
  @JsonKey(name: "phone")
  String? phone;
  @JsonKey(name: "link")
  String? link;

  ContactsResponse(this.email, this.phone, this.link);
  factory ContactsResponse.fromJson(Map<String, dynamic> json) =>
      _$ContactsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ContactsResponseToJson(this);
}

@JsonSerializable()
class AuthenticationResponse extends BaseResponse {
  @JsonKey(name: "customer")
  CustomerResponse? customer;
  @JsonKey(name: "contacts")
  ContactsResponse? contacts;

  AuthenticationResponse({this.customer, this.contacts});
// fromJson
  factory AuthenticationResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthenticationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AuthenticationResponseToJson(this);

  // to json
}

@JsonSerializable()
class ForgotPasswordResponse extends BaseResponse {
  @JsonKey(name: "support")
  String? support;
  ForgotPasswordResponse(this.support);

  factory ForgotPasswordResponse.fromJson(Map<String, dynamic> json) =>
      _$ForgotPasswordResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ForgotPasswordResponseToJson(this);
}

//? HOME RESPONSES
@JsonSerializable()
class ServicesResponse {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "image")
  String? image;
  ServicesResponse(this.id, this.title, this.image);

  Map<String, dynamic> toJson() => _$ServicesResponseToJson(this);

  factory ServicesResponse.fromJson(Map<String, dynamic> json) =>
      _$ServicesResponseFromJson(json);
}

@JsonSerializable()
class BannersResponse {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "image")
  String? image;
  BannersResponse(this.id, this.title, this.image);

  Map<String, dynamic> toJson() => _$BannersResponseToJson(this);

  factory BannersResponse.fromJson(Map<String, dynamic> json) =>
      _$BannersResponseFromJson(json);
}

@JsonSerializable()
class StoresResponse {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "link")
  String? link;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "image")
  String? image;
  StoresResponse(this.id, this.link, this.title, this.image);

  Map<String, dynamic> toJson() => _$StoresResponseToJson(this);

  factory StoresResponse.fromJson(Map<String, dynamic> json) =>
      _$StoresResponseFromJson(json);
}

@JsonSerializable()
class HomeDataResponse {
  @JsonKey(name: 'services')
  List<ServicesResponse>? services;
  @JsonKey(name: 'banners')
  List<ServicesResponse>? banners;
  @JsonKey(name: 'stores')
  List<ServicesResponse>? stores;

  HomeDataResponse(this.services, this.banners, this.stores);

  Map<String, dynamic> toJson() => _$HomeDataResponseToJson(this);

  factory HomeDataResponse.fromJson(Map<String, dynamic> json) =>
      _$HomeDataResponseFromJson(json);
}

@JsonSerializable()
class HomeResponse extends BaseResponse {
  @JsonKey(name: 'data')
  HomeDataResponse? data;

  HomeResponse(this.data);

  Map<String, dynamic> toJson() => _$HomeResponseToJson(this);

  factory HomeResponse.fromJson(Map<String, dynamic> json) =>
      _$HomeResponseFromJson(json);
}
