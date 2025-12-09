// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthData _$AuthDataFromJson(Map<String, dynamic> json) => AuthData(
      token: json['token'] as String,
      id: json['_id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      storeName: json['store_name'] as String,
      storeId: json['store_id'] as String,
      storeUrl: json['store_url'] as String,
      storeLogo: json['store_logo'] as String,
      contentUrl: json['content_url'] as String,
    );

Map<String, dynamic> _$AuthDataToJson(AuthData instance) => <String, dynamic>{
      'token': instance.token,
      '_id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'store_name': instance.storeName,
      'store_id': instance.storeId,
      'store_url': instance.storeUrl,
      'store_logo': instance.storeLogo,
      'content_url': instance.contentUrl,
    };
