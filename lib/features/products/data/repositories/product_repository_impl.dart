import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_remote_datasource.dart';

@LazySingleton(as: ProductRepository)
class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource _dataSource;

  ProductRepositoryImpl(this._dataSource);

  @override
  Future<Either<Failure, List<ProductEntity>>> getMostPurchased({
    required String storeId,
    int page = 1,
    int limit = 10,
  }) async {
    final result = await _dataSource.getMostPurchased(
      storeId: storeId,
      page: page,
      limit: limit,
    );
    return result.fold((failure) => Left(failure), (data) => Right(data));
  }

  @override
  Future<Either<Failure, ProductEntity>> getProductDetails({
    required String storeId,
    required String productId,
  }) async {
    final result = await _dataSource.getProductDetails(
      storeId: storeId,
      productId: productId,
    );
    return result.fold((failure) => Left(failure), (data) => Right(data));
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getProductsByCategory({
    required String storeId,
    required String categoryId,
    int page = 1,
    int limit = 10,
  }) async {
    final result = await _dataSource.getProductsByCategory(
      storeId: storeId,
      categoryId: categoryId,
      page: page,
      limit: limit,
    );
    return result.fold((failure) => Left(failure), (data) => Right(data));
  }
}
