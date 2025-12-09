import 'dart:async';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

// Re-export the interface
abstract class StorageServiceInterface {
  void saveData(String key, String value);
  Future<Map<String, dynamic>?> getData(String key);
}

class MobileStorageService implements StorageServiceInterface {
  @override
  void saveData(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  @override
  Future<Map<String, dynamic>?> getData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString(key);
    if (value == null) return null;

    try {
      return jsonDecode(value) as Map<String, dynamic>;
    } catch (e) {
      return {"error": "Failed to parse data: $e"};
    }
  }
}

StorageServiceInterface getStorageService() => MobileStorageService();
