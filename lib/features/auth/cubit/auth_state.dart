import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/models/auth_data.dart';

part 'auth_state.freezed.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial({
    AuthData? data,
    @Default(false) bool loading,
    String? errorMessage,
  }) = AuthInitial;

  const factory AuthState.loading({
    AuthData? data,
    @Default(true) bool loading,
    String? errorMessage,
  }) = AuthLoading;

  const factory AuthState.authenticated({
    required AuthData data,
    @Default(false) bool loading,
    String? errorMessage,
  }) = AuthAuthenticated;

  const factory AuthState.error({
    AuthData? data,
    @Default(false) bool loading,
    required String errorMessage,
  }) = AuthError;

  const factory AuthState.unauthenticated({
    AuthData? data,
    @Default(false) bool loading,
    String? errorMessage,
  }) = AuthUnauthenticated;
}
