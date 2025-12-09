import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../core/network/network_handler.dart';
import '../../../../utils/injector/injector.dart';
import '../../domain/entities/category_entity.dart';
import '../models/category_model.dart';

abstract class CategoryRemoteDataSource {
  Future<Either<Failure, List<CategoryEntity>>> getAllCategories({
    required String storeId,
    int page = 1,
    int limit = 10,
  });
}

@LazySingleton(as: CategoryRemoteDataSource)
class CategoryRemoteDataSourceImpl implements CategoryRemoteDataSource {
  @override
  Future<Either<Failure, List<CategoryEntity>>> getAllCategories({
    required String storeId,
    int page = 1,
    int limit = 10,
  }) async {
    try {
      final response = await getIt<DioClient>()
          .getInstance()
          .get<Map<String, dynamic>>(
            '/stores/categories/store_id/$storeId',
            queryParameters: {'page': page, 'limit': limit},
          );
      final responseData = response.data!;
      final resultsList = (responseData['results']['data'] as List)
          .map(
            (item) => CategoryModel.fromJson(
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
