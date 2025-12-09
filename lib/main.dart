import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'config/store_app.dart';
import 'core/di/injection_container.dart';
import 'core/utils/app_credentials.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize shared preferences
  await SharedPreferences.getInstance();

  // Create store configuration
  const storeConfig = StoreConfig(
    apiBaseUrl: 'https://api.myexperience.center/api/web',
    credentials: AppCredentials(),
    permissions: AppPermissions(),
    enableLogging: true,
    requestTimeoutSeconds: 30,
  );

  // Setup dependency injection
  await configureDependencies(storeConfig);

  runApp(const StoreApp());
}
