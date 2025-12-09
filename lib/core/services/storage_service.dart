// mini_app/lib/storage_service.dart
import 'dart:async';

import 'package:injectable/injectable.dart';

import 'storage_service_stub.dart'
    if (dart.library.html) 'storage_service_web.dart'
    if (dart.library.io) 'storage_service_mobile.dart';

@injectable
class MiniAppStorageService implements StorageServiceInterface {
  final StorageServiceInterface _implementation = getStorageService();

  @override
  void saveData(String key, String value) {
    _implementation.saveData(key, value);
  }

  @override
  Future<Map<String, dynamic>?> getData(String key) {
    return _implementation.getData(key);
  }
}
