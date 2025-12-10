import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_strategy/url_strategy.dart';

import 'config/store_app.dart';
import 'core/utils/app_credentials.dart';
import 'utils/injector/injector.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize shared preferences
  await SharedPreferences.getInstance();

  // Create store configuration
  const storeConfig = StoreConfig(
    apiBaseUrl: 'https://api.myexperience.center/api/web',

    enableLogging: true,
    requestTimeoutSeconds: 30,
  );
  setPathUrlStrategy();
  // Setup dependency injection
  await registerDependencies(storeConfig);

  runApp(const StoreApp());
}
