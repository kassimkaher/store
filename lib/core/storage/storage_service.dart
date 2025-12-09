import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

abstract class StorageService {
  /// Get string value from storage
  Future<String?> getString(String key);

  /// Save string value to storage
  Future<void> setString(String key, String value);

  /// Get int value from storage
  Future<int?> getInt(String key);

  /// Save int value to storage
  Future<void> setInt(String key, int value);

  /// Get bool value from storage
  Future<bool?> getBool(String key);

  /// Save bool value to storage
  Future<void> setBool(String key, bool value);

  /// Get list from storage (stored as JSON)
  Future<List<T>> getList<T>(
    String key, {
    required T Function(Map<String, dynamic>) fromJson,
  });

  /// Save list to storage (stored as JSON)
  Future<void> setList<T>(
    String key,
    List<T> value, {
    required Map<String, dynamic> Function(T) toJson,
  });

  /// Get JSON object from storage
  Future<T?> getJson<T>(
    String key, {
    required T Function(Map<String, dynamic>) fromJson,
  });

  /// Save JSON object to storage
  Future<void> setJson<T>(
    String key,
    T value, {
    required Map<String, dynamic> Function(T) toJson,
  });

  /// Remove a key from storage
  Future<void> remove(String key);

  /// Clear all data from storage
  Future<void> clear();

  /// Check if key exists
  Future<bool> containsKey(String key);

  /// Get all keys
  Future<Set<String>> getKeys();
}

class SharedPreferencesStorageService implements StorageService {
  final SharedPreferences _preferences;

  SharedPreferencesStorageService(this._preferences);

  @override
  Future<String?> getString(String key) async {
    return _preferences.getString(key);
  }

  @override
  Future<void> setString(String key, String value) async {
    await _preferences.setString(key, value);
  }

  @override
  Future<int?> getInt(String key) async {
    return _preferences.getInt(key);
  }

  @override
  Future<void> setInt(String key, int value) async {
    await _preferences.setInt(key, value);
  }

  @override
  Future<bool?> getBool(String key) async {
    return _preferences.getBool(key);
  }

  @override
  Future<void> setBool(String key, bool value) async {
    await _preferences.setBool(key, value);
  }

  @override
  Future<List<T>> getList<T>(
    String key, {
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    final jsonString = _preferences.getString(key);
    if (jsonString == null) return [];

    final List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList
        .cast<Map<String, dynamic>>()
        .map((item) => fromJson(item))
        .toList();
  }

  @override
  Future<void> setList<T>(
    String key,
    List<T> value, {
    required Map<String, dynamic> Function(T) toJson,
  }) async {
    final jsonList = value.map((item) => toJson(item)).toList();
    await _preferences.setString(key, jsonEncode(jsonList));
  }

  @override
  Future<T?> getJson<T>(
    String key, {
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    final jsonString = _preferences.getString(key);
    if (jsonString == null) return null;

    final json = jsonDecode(jsonString);
    return fromJson(json);
  }

  @override
  Future<void> setJson<T>(
    String key,
    T value, {
    required Map<String, dynamic> Function(T) toJson,
  }) async {
    final json = toJson(value);
    await _preferences.setString(key, jsonEncode(json));
  }

  @override
  Future<void> remove(String key) async {
    await _preferences.remove(key);
  }

  @override
  Future<void> clear() async {
    await _preferences.clear();
  }

  @override
  Future<bool> containsKey(String key) async {
    return _preferences.containsKey(key);
  }

  @override
  Future<Set<String>> getKeys() async {
    return _preferences.getKeys();
  }
}
