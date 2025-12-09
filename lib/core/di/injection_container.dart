import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/bookmarks/presentation/cubit/bookmark_cubit.dart';
import '../../features/cart/domain/usecases/cart_usecases.dart';
import '../../features/cart/presentation/cubit/cart_cubit.dart';
import '../../features/category/domain/usecases/get_all_categories_usecase.dart';
import '../../features/offers/domain/usecases/offer_usecases.dart';
import '../../features/products/domain/usecases/product_usecases.dart';
import '../../features/search/domain/usecases/search_usecases.dart'
    as search_usecases;
import '../storage/storage_service.dart';
import '../utils/app_credentials.dart';
import 'injection_container.config.dart';

final getIt = GetIt.instance;

@injectableInit
Future<void> configureDependencies(StoreConfig storeConfig) async {
  // Get It setup
  final sharedPreferences = await SharedPreferences.getInstance();

  // Core Services - Register dependencies needed by @injectable classes
  getIt.registerSingleton<SharedPreferences>(sharedPreferences);
  getIt.registerSingleton<StorageService>(
    SharedPreferencesStorageService(sharedPreferences),
  );
  getIt.registerSingleton<StoreConfig>(storeConfig);

  // Initialize injectable dependencies - this will auto-register all
  // @injectable/@lazySingleton annotated classes (datasources & repositories)
  getIt.init();

  // Use Cases
  getIt.registerLazySingleton<GetAllCategoriesUseCase>(
    () => GetAllCategoriesUseCase(getIt()),
  );
  getIt.registerLazySingleton<GetOffersUseCase>(
    () => GetOffersUseCase(getIt()),
  );
  getIt.registerLazySingleton<SearchOffersUseCase>(
    () => SearchOffersUseCase(getIt()),
  );
  getIt.registerLazySingleton<GetMostPurchasedUseCase>(
    () => GetMostPurchasedUseCase(getIt()),
  );
  getIt.registerLazySingleton<GetProductDetailsUseCase>(
    () => GetProductDetailsUseCase(getIt()),
  );
  getIt.registerLazySingleton<GetProductsByCategoryUseCase>(
    () => GetProductsByCategoryUseCase(getIt()),
  );
  getIt.registerLazySingleton<search_usecases.SearchAllUseCase>(
    () => search_usecases.SearchAllUseCase(repository: getIt()),
  );
  getIt.registerLazySingleton<search_usecases.SearchProductsUseCase>(
    () => search_usecases.SearchProductsUseCase(repository: getIt()),
  );
  getIt.registerLazySingleton<search_usecases.SearchOffersInResultsUseCase>(
    () => search_usecases.SearchOffersInResultsUseCase(repository: getIt()),
  );

  // Cart Use Cases
  getIt.registerLazySingleton<GetMyCartOrdersUseCase>(
    () => GetMyCartOrdersUseCase(getIt()),
  );
  getIt.registerLazySingleton<SubmitCartUseCase>(
    () => SubmitCartUseCase(getIt()),
  );

  // Cart Cubit - Singleton
  getIt.registerLazySingleton<CartCubit>(() => CartCubit());

  // Bookmark Cubit - Singleton
  getIt.registerLazySingleton<BookmarkCubit>(() => BookmarkCubit());
}

void setupServiceLocator() {
  // This will be called from main.dart after DI setup
}
