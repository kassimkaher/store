import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/storage/storage_service.dart';
import '../../core/utils/app_credentials.dart';
import 'injector.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
Future<void> registerDependencies(StoreConfig storeConfig) async {
  // Register StoreConfig
  getIt.registerSingleton<StoreConfig>(storeConfig);

  // Register StorageService
  final prefs = await SharedPreferences.getInstance();
  getIt.registerSingleton<StorageService>(
    SharedPreferencesStorageService(prefs),
  );

  // Register generated dependencies
  getIt.init();
}
