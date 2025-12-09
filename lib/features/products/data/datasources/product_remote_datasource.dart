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
          .getInstance()
          .get<Map<String, dynamic>>(
            '/stores/products/store_id/$storeId/mostPurchased',
            queryParameters: {'page': page, 'limit': limit},
          );
      final responseData = response.data!;
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
          .getInstance()
          .get<Map<String, dynamic>>(
            '/stores/products/$productId/store_id/$storeId',
          );
      return Right(ProductModel.fromJson(response.data!).toEntity());
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
          .getInstance()
          .get<Map<String, dynamic>>(
            '/stores/products/store_id/$storeId',
            queryParameters: {
              'page': page,
              'limit': limit,
              'category_id': categoryId,
            },
          );
      final responseData = response.data!;
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
