// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'responses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerResponse _$CustomerResponseFromJson(Map<String, dynamic> json) =>
    CustomerResponse(
      json['id'] as String?,
      json['name'] as String?,
      json['numOfNotifications'] as int?,
    );

Map<String, dynamic> _$CustomerResponseToJson(CustomerResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'numOfNotifications': instance.numOfNotifications,
    };

ContactsResponse _$ContactsResponseFromJson(Map<String, dynamic> json) =>
    ContactsResponse(
      json['email'] as String?,
      json['phone'] as String?,
      json['link'] as String?,
    );

Map<String, dynamic> _$ContactsResponseToJson(ContactsResponse instance) =>
    <String, dynamic>{
      'email': instance.email,
      'phone': instance.phone,
      'link': instance.link,
    };

AuthenticationResponse _$AuthenticationResponseFromJson(
        Map<String, dynamic> json) =>
    AuthenticationResponse(
      customer: json['customer'] == null
          ? null
          : CustomerResponse.fromJson(json['customer'] as Map<String, dynamic>),
      contacts: json['contacts'] == null
          ? null
          : ContactsResponse.fromJson(json['contacts'] as Map<String, dynamic>),
    )
      ..status = json['status'] as int?
      ..message = json['message'] as String?;

Map<String, dynamic> _$AuthenticationResponseToJson(
        AuthenticationResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'customer': instance.customer,
      'contacts': instance.contacts,
    };

ForgotPasswordResponse _$ForgotPasswordResponseFromJson(
        Map<String, dynamic> json) =>
    ForgotPasswordResponse(
      json['support'] as String?,
    )
      ..status = json['status'] as int?
      ..message = json['message'] as String?;

Map<String, dynamic> _$ForgotPasswordResponseToJson(
        ForgotPasswordResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'support': instance.support,
    };

ServicesResponse _$ServicesResponseFromJson(Map<String, dynamic> json) =>
    ServicesResponse(
      json['id'] as int?,
      json['title'] as String?,
      json['image'] as String?,
    );

Map<String, dynamic> _$ServicesResponseToJson(ServicesResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'image': instance.image,
    };

BannersResponse _$BannersResponseFromJson(Map<String, dynamic> json) =>
    BannersResponse(
      json['id'] as int?,
      json['title'] as String?,
      json['image'] as String?,
    );

Map<String, dynamic> _$BannersResponseToJson(BannersResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'image': instance.image,
    };

StoresResponse _$StoresResponseFromJson(Map<String, dynamic> json) =>
    StoresResponse(
      json['id'] as int?,
      json['link'] as String?,
      json['title'] as String?,
      json['image'] as String?,
    );

Map<String, dynamic> _$StoresResponseToJson(StoresResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'link': instance.link,
      'title': instance.title,
      'image': instance.image,
    };

HomeDataResponse _$HomeDataResponseFromJson(Map<String, dynamic> json) =>
    HomeDataResponse(
      (json['services'] as List<dynamic>?)
          ?.map((e) => ServicesResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['banners'] as List<dynamic>?)
          ?.map((e) => ServicesResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['stores'] as List<dynamic>?)
          ?.map((e) => ServicesResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$HomeDataResponseToJson(HomeDataResponse instance) =>
    <String, dynamic>{
      'services': instance.services,
      'banners': instance.banners,
      'stores': instance.stores,
    };

HomeResponse _$HomeResponseFromJson(Map<String, dynamic> json) => HomeResponse(
      json['data'] == null
          ? null
          : HomeDataResponse.fromJson(json['data'] as Map<String, dynamic>),
    )
      ..status = json['status'] as int?
      ..message = json['message'] as String?;

Map<String, dynamic> _$HomeResponseToJson(HomeResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };
