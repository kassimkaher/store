import 'package:equatable/equatable.dart';

class AppCredentials extends Equatable {
  final String? userId;
  final String? token;
  final String? userName;
  final String? userEmail;
  final Map<String, dynamic>? metadata;

  const AppCredentials({
    this.userId,
    this.token,
    this.userName,
    this.userEmail,
    this.metadata,
  });

  bool get isAuthenticated => userId != null && token != null;

  @override
  List<Object?> get props => [userId, token, userName, userEmail, metadata];
}

class AppPermissions extends Equatable {
  final List<String> grantedPermissions;
  final bool canViewItems;
  final bool canPlaceOrder;
  final bool canSearch;
  final bool canViewPrice;

  const AppPermissions({
    this.grantedPermissions = const [],
    this.canViewItems = true,
    this.canPlaceOrder = false,
    this.canSearch = true,
    this.canViewPrice = true,
  });

  bool hasPermission(String permission) =>
      grantedPermissions.contains(permission);

  @override
  List<Object?> get props => [
    grantedPermissions,
    canViewItems,
    canPlaceOrder,
    canSearch,
    canViewPrice,
  ];
}

class StoreConfig extends Equatable {
  final String apiBaseUrl;
  final String? apiKey;

  final bool enableLogging;
  final int requestTimeoutSeconds;

  const StoreConfig({
    required this.apiBaseUrl,
    this.apiKey,

    this.enableLogging = false,
    this.requestTimeoutSeconds = 30,
  });

  @override
  List<Object?> get props => [
    apiBaseUrl,
    apiKey,

    enableLogging,
    requestTimeoutSeconds,
  ];
}
