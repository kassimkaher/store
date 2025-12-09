import 'dart:async';
import 'dart:convert';
import 'dart:js_interop';

import 'web_bridg.dart';

// Re-export the interface
abstract class StorageServiceInterface {
  void saveData(String key, String value);
  Future<Map<String, dynamic>?> getData(String key);
}

class WebStorageService implements StorageServiceInterface {
  final _dataController = StreamController<Map<String, dynamic>>.broadcast();

  WebStorageService() {
    onNativeDataReceived = (JSString jsonString) {
      final dartString = jsonString.toDart;
      final data = jsonDecode(dartString);
      _dataController.add(data);
    }.toJS;
  }

  @override
  void saveData(String key, String value) {
    final message = jsonEncode({'type': 'SAVE', 'key': key, 'value': value});
    nativeBridge.postMessage(message.toJS);
  }

  @override
  Future<Map<String, dynamic>?> getData(String key) async {
    final message = jsonEncode({'type': 'GET', 'key': key});
    nativeBridge.postMessage(message.toJS);

    try {
      final response = await _dataController.stream.first.timeout(
        const Duration(seconds: 2),
      );
      return response;
    } catch (e) {
      return {"error": "error message$e"};
    }
  }
}

StorageServiceInterface getStorageService() => WebStorageService();
