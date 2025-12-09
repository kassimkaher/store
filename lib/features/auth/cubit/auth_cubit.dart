import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../core/models/auth_data.dart';
import '../../../core/services/storage_service.dart';
import 'auth_state.dart';

@singleton
class AuthCubit extends Cubit<AuthState> {
  final MiniAppStorageService _storageService;

  AuthCubit(this._storageService) : super(const AuthState.initial());

  /// Load authentication data from storage
  Future<void> loadAuthData() async {
    emit(
      AuthState.authenticated(
        data: AuthData(
          token:
              "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2OGQxMDlkYjg5YmZjNjczMGQ1YzNlMjciLCJuYW1lIjoiTGFtYXNzdSIsImVtYWlsIjoib253ZXJBcHAyM0BhbG5hc2ltLmNvbSIsInBob25lIjoiMDc4MTIzNDU2NzgiLCJ0eXBlIjoib3duZXIiLCJjZW50ZXJfaWQiOiI2N2I0NDUxZmU5ZGI2NGUwNDUxZGNmODIiLCJtYXJrZXRpbmdfY29tcGFueV9pZCI6bnVsbCwibWFya2V0aW5nX2NvbXBhbnlfYnJhbmNoX25hbWUiOm51bGwsImlhdCI6MTc2NTIyMzE0OH0.NfLSmr03bDJ5vxqeRmGpM50AYt4HypMd1cSaAl3Z9cM",
          id: "22",
          name: "test kassi,",
          email: "email",
          phone: "07722727272",
          storeName: "storeName",
          storeId: "6928976e1dbcf278d2271186",
          storeUrl: "storeUrl",
          storeLogo: "storeLogo",
          contentUrl: "contentUrl",
        ),
      ),
    );
    return;
    try {
      emit(const AuthState.loading());

      // Get auth data from storage service
      final authDataJson = await _storageService.getData('auth_data');

      if (authDataJson == null || authDataJson.isEmpty) {
        emit(const AuthState.unauthenticated());
        return;
      }
      if (authDataJson.containsKey("error")) {
        return emit(
          AuthState.error(
            errorMessage:
                'Failed to load authentication data: ${authDataJson["error"]}',
          ),
        );
      }

      // Parse JSON string to Map
      final Map<String, dynamic> authDataMap = authDataJson['auth_data'];

      // Convert to AuthData model
      final authData = AuthData.fromJson(authDataMap);

      emit(AuthState.authenticated(data: authData));
    } catch (e) {
      emit(
        AuthState.error(
          errorMessage: 'Failed to load authentication data: ${e.toString()}',
        ),
      );
    }
  }

  /// Save authentication data to storage
  Future<void> saveAuthData(AuthData authData) async {
    try {
      emit(const AuthState.loading());

      // Convert AuthData to JSON string
      final authDataJson = jsonEncode(authData.toJson());

      // Save to storage service
      _storageService.saveData('auth_data', authDataJson);

      emit(AuthState.authenticated(data: authData));
    } catch (e) {
      emit(
        AuthState.error(
          errorMessage: 'Failed to save authentication data: ${e.toString()}',
        ),
      );
    }
  }

  /// Update specific fields in auth data
  Future<void> updateAuthData({
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
  }) async {
    await state.maybeWhen(
      authenticated: (data, loading, errorMessage) async {
        try {
          final updatedAuthData = data.copyWith(
            token: token,
            id: id,
            name: name,
            email: email,
            phone: phone,
            storeName: storeName,
            storeId: storeId,
            storeUrl: storeUrl,
            storeLogo: storeLogo,
            contentUrl: contentUrl,
          );

          await saveAuthData(updatedAuthData);
        } catch (e) {
          emit(
            AuthState.error(
              errorMessage:
                  'Failed to update authentication data: ${e.toString()}',
            ),
          );
        }
      },
      orElse: () async {
        emit(
          const AuthState.error(
            errorMessage: 'Cannot update: user not authenticated',
          ),
        );
      },
    );
  }

  /// Logout and clear auth data
  Future<void> logout() async {
    try {
      // Clear storage (you might want to implement clearData in StorageService)
      _storageService.saveData('auth_data', '');
      emit(const AuthState.unauthenticated());
    } catch (e) {
      emit(AuthState.error(errorMessage: 'Failed to logout: ${e.toString()}'));
    }
  }

  /// Get current auth data if authenticated
  AuthData? get currentAuthData {
    return state.maybeWhen(
      authenticated: (data, loading, errorMessage) => data,
      orElse: () => null,
    );
  }

  /// Check if user is authenticated
  bool get isAuthenticated => state.maybeWhen(
    authenticated: (data, loading, errorMessage) => true,
    orElse: () => false,
  );
  String? getStorId() {
    return state.maybeWhen(
      authenticated: (data, loading, errorMessage) => data.storeId,
      orElse: () => null,
    );
  }
}
