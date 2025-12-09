import 'package:json_annotation/json_annotation.dart';

part 'auth_data.g.dart';

@JsonSerializable()
class AuthData {
  final String token;
  @JsonKey(name: '_id')
  final String id;
  final String name;
  final String email;
  final String phone;
  @JsonKey(name: 'store_name')
  final String storeName;
  @JsonKey(name: 'store_id')
  final String storeId;
  @JsonKey(name: 'store_url')
  final String storeUrl;
  @JsonKey(name: 'store_logo')
  final String storeLogo;
  @JsonKey(name: 'content_url')
  final String contentUrl;

  AuthData({
    required this.token,
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.storeName,
    required this.storeId,
    required this.storeUrl,
    required this.storeLogo,
    required this.contentUrl,
  });

  factory AuthData.fromJson(Map<String, dynamic> json) =>
      _$AuthDataFromJson(json);

  Map<String, dynamic> toJson() => _$AuthDataToJson(this);

  AuthData copyWith({
    String? token,
    String? id,
    String? name,
    String? email,
    String? phone,
    String? storeName,
    String? storeId,
    String? storeUrl,
    String? storeLogo,
    String? contentUrl,
  }) {
    return AuthData(
      token: token ?? this.token,
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      storeName: storeName ?? this.storeName,
      storeId: storeId ?? this.storeId,
      storeUrl: storeUrl ?? this.storeUrl,
      storeLogo: storeLogo ?? this.storeLogo,
      contentUrl: contentUrl ?? this.contentUrl,
    );
  }
}
