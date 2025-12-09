// mini_app/lib/web_bridge.dart
import 'dart:js_interop';

// 1. Define the NativeBridge that the Host injected
@JS('NativeBridge')
external NativeBridge get nativeBridge;

extension type NativeBridge(JSObject _) implements JSObject {
  external void postMessage(JSString message);
}

// 2. Define a function to receive data FROM Host
// We assign this to "window" so the Host can call window.onNativeDataReceived(...)
@JS('window.onNativeDataReceived')
external set onNativeDataReceived(JSFunction f);
