// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:store_web/core/network/dio_client.dart' as _i687;
import 'package:store_web/core/services/storage_service.dart' as _i454;
import 'package:store_web/core/storage/storage_service.dart' as _i1051;
import 'package:store_web/core/utils/app_credentials.dart' as _i88;
import 'package:store_web/features/auth/cubit/auth_cubit.dart' as _i47;
import 'package:store_web/features/cart/data/datasources/cart_remote_datasource.dart'
    as _i973;
import 'package:store_web/features/cart/data/repositories/cart_repository_impl.dart'
    as _i252;
import 'package:store_web/features/cart/domain/repositories/cart_repository.dart'
    as _i839;
import 'package:store_web/features/category/data/datasources/category_remote_datasource.dart'
    as _i591;
import 'package:store_web/features/category/data/repositories/category_repository_impl.dart'
    as _i750;
import 'package:store_web/features/category/domain/repositories/category_repository.dart'
    as _i936;
import 'package:store_web/features/offers/data/datasources/offer_remote_datasource.dart'
    as _i1068;
import 'package:store_web/features/offers/data/repositories/offer_repository_impl.dart'
    as _i668;
import 'package:store_web/features/offers/domain/repositories/offer_repository.dart'
    as _i122;
import 'package:store_web/features/products/data/datasources/product_remote_datasource.dart'
    as _i785;
import 'package:store_web/features/products/data/repositories/product_repository_impl.dart'
    as _i322;
import 'package:store_web/features/products/domain/repositories/product_repository.dart'
    as _i52;
import 'package:store_web/features/search/data/datasources/search_remote_datasource.dart'
    as _i862;
import 'package:store_web/features/search/data/repositories/search_repository_impl.dart'
    as _i232;
import 'package:store_web/features/search/domain/repositories/search_repository.dart'
    as _i227;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i454.MiniAppStorageService>(
        () => _i454.MiniAppStorageService());
    gh.lazySingleton<_i973.CartRemoteDataSource>(
        () => _i973.CartRemoteDataSourceImpl());
    gh.lazySingleton<_i785.ProductRemoteDataSource>(
        () => _i785.ProductRemoteDataSourceImpl());
    gh.lazySingleton<_i687.DioClient>(() => _i687.DioClient(
          config: gh<_i88.StoreConfig>(),
          storageService: gh<_i1051.StorageService>(),
        ));
    gh.lazySingleton<_i1068.OfferRemoteDataSource>(
        () => _i1068.OfferRemoteDataSourceImpl());
    gh.lazySingleton<_i122.OfferRepository>(
        () => _i668.OfferRepositoryImpl(gh<_i1068.OfferRemoteDataSource>()));
    gh.lazySingleton<_i591.CategoryRemoteDataSource>(
        () => _i591.CategoryRemoteDataSourceImpl());
    gh.singleton<_i47.AuthCubit>(
        () => _i47.AuthCubit(gh<_i454.MiniAppStorageService>()));
    gh.lazySingleton<_i862.SearchRemoteDataSource>(
        () => _i862.SearchRemoteDataSourceImpl(
              gh<_i785.ProductRemoteDataSource>(),
              gh<_i1068.OfferRemoteDataSource>(),
            ));
    gh.lazySingleton<_i839.CartRepository>(
        () => _i252.CartRepositoryImpl(gh<_i973.CartRemoteDataSource>()));
    gh.lazySingleton<_i52.ProductRepository>(
        () => _i322.ProductRepositoryImpl(gh<_i785.ProductRemoteDataSource>()));
    gh.lazySingleton<_i936.CategoryRepository>(() =>
        _i750.CategoryRepositoryImpl(gh<_i591.CategoryRemoteDataSource>()));
    gh.lazySingleton<_i227.SearchRepository>(
        () => _i232.SearchRepositoryImpl(gh<_i862.SearchRemoteDataSource>()));
    return this;
  }
}
