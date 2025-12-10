import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:store_web/features/products/domain/entities/product_entity.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entities/search_result_entity.dart';
import '../../domain/repositories/search_repository.dart';
import '../datasources/search_remote_datasource.dart';

@LazySingleton(as: SearchRepository)
class SearchRepositoryImpl implements SearchRepository {
  final SearchRemoteDataSource _dataSource;

  SearchRepositoryImpl(this._dataSource);

  @override
  Future<Either<Failure, List<ProductEntity>>> searchProducts({
    required String storeId,
    required String query,
    int page = 1,
    int limit = 20,
  }) async {
    return await _dataSource.searchProducts(
      storeId: storeId,
      query: query,
      page: page,
      limit: limit,
    );
  }

  @override
  Future<Either<Failure, List<SearchResultEntity>>> searchOffers({
    required String storeId,
    required String query,
    int page = 1,
    int limit = 20,
  }) async {
    return await _dataSource.searchOffers(
      storeId: storeId,
      query: query,
      page: page,
      limit: limit,
    );
  }
}
