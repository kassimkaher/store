import 'dart:async';

abstract class StorageServiceInterface {
  void saveData(String key, String value);
  Future<Map<String, dynamic>?> getData(String key);
}

// Stub implementation - will be replaced by platform-specific version
class StubStorageService implements StorageServiceInterface {
  @override
  void saveData(String key, String value) {
    throw UnsupportedError('Storage not supported on this platform');
  }

  @override
  Future<Map<String, dynamic>?> getData(String key) {
    throw UnsupportedError('Storage not supported on this platform');
  }
}

StorageServiceInterface getStorageService() => StubStorageService();
