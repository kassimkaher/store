import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../core/network/network_handler.dart';
import '../../../../utils/injector/injector.dart';
import '../../domain/entities/product_entity.dart';
import '../models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<Either<Failure, List<ProductEntity>>> getMostPurchased({
    required String storeId,
    int page = 1,
    int limit = 10,
  });
  Future<Either<Failure, ProductEntity>> getProductDetails({
    required String storeId,
    required String productId,
  });
  Future<Either<Failure, List<ProductEntity>>> getProductsByCategory({
    required String storeId,
    required String categoryId,
    int page = 1,
    int limit = 10,
  });
}

@LazySingleton(as: ProductRemoteDataSource)
class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  @override
  Future<Either<Failure, List<ProductEntity>>> getMostPurchased({
    required String storeId,
    int page = 1,
    int limit = 10,
  }) async {
    try {
      final response = await getIt<DioClient>()
          .instance()
          .products
          .getMostPurchased(storeId: storeId, page: page, limit: limit);
      final responseData = response.data as Map<String, dynamic>;
      final resultsList = (responseData['results'] as List)
          .map(
            (item) => ProductModel.fromJson(
              item as Map<String, dynamic>,
            ).toEntity(responseData['r2_base_url'] as String?),
          )
          .toList();
      return Right(resultsList);
    } on DioException catch (e) {
      return Left(NetworkHandler.handleDioException(e));
    }
  }

  @override
  Future<Either<Failure, ProductEntity>> getProductDetails({
    required String storeId,
    required String productId,
  }) async {
    try {
      final response = await getIt<DioClient>()
          .instance()
          .products
          .getProductDetails(productId: productId, storeId: storeId);
      final responseData = response.data as Map<String, dynamic>;
      return Right(
        ProductModel.fromJson(
          responseData['results'],
        ).toEntity(responseData['r2_base_url'] as String?),
      );
    } on DioException catch (e) {
      return Left(NetworkHandler.handleDioException(e));
    }
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getProductsByCategory({
    required String storeId,
    required String categoryId,
    int page = 1,
    int limit = 10,
  }) async {
    try {
      final response = await getIt<DioClient>()
          .instance()
          .products
          .getProductsByCategory(
            storeId: storeId,
            categoryId: categoryId,
            page: page,
            limit: limit,
          );
      final responseData = response.data as Map<String, dynamic>;
      final resultsList = (responseData['results']['data'] as List)
          .map(
            (item) => ProductModel.fromJson(
              item as Map<String, dynamic>,
            ).toEntity(responseData['r2_base_url'] as String?),
          )
          .toList();
      return Right(resultsList);
    } on DioException catch (e) {
      return Left(NetworkHandler.handleDioException(e));
    }
  }
}
