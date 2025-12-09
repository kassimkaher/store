import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../core/network/network_handler.dart';
import '../../../../utils/injector/injector.dart';
import '../../domain/entities/offer_entity.dart';
import '../models/offer_model.dart';

abstract class OfferRemoteDataSource {
  Future<Either<Failure, List<OfferEntity>>> getOffers({
    required String storeId,
    int page = 1,
    int limit = 10,
  });
  Future<Either<Failure, List<OfferEntity>>> searchOffers({
    required String storeId,
    required String search,
    int page = 1,
    int limit = 10,
  });
}

@LazySingleton(as: OfferRemoteDataSource)
class OfferRemoteDataSourceImpl implements OfferRemoteDataSource {
  @override
  Future<Either<Failure, List<OfferEntity>>> getOffers({
    required String storeId,
    int page = 1,
    int limit = 10,
  }) async {
    try {
      final response = await getIt<DioClient>()
          .getInstance()
          .get<Map<String, dynamic>>(
            '/stores/offers/store_id/$storeId',
            queryParameters: {'page': page, 'limit': limit},
          );
      final responseData = response.data!;
      final contentUrl = responseData['r2_base_url'] as String?;
      final resultsList = (responseData['results']['data'] as List).map((item) {
        final model = OfferModel.fromJson(item as Map<String, dynamic>);
        // Create new model with contentUrl if model's contentUrl is null
        final modelWithUrl = model.contentUrl == null && contentUrl != null
            ? OfferModel(
                id: model.id,
                image: model.image,
                contentUrl: contentUrl,
                note: model.note,
              )
            : model;
        return modelWithUrl.toEntity();
      }).toList();
      return Right(resultsList);
    } on DioException catch (e) {
      return Left(NetworkHandler.handleDioException(e));
    }
  }

  @override
  Future<Either<Failure, List<OfferEntity>>> searchOffers({
    required String storeId,
    required String search,
    int page = 1,
    int limit = 10,
  }) async {
    try {
      final response = await getIt<DioClient>()
          .getInstance()
          .get<Map<String, dynamic>>(
            '/stores/offers/store_id/$storeId',
            queryParameters: {'page': page, 'limit': limit, 'search': search},
          );
      final responseData = response.data!;
      final resultsList = (responseData['results']['data'] as List)
          .map(
            (item) =>
                OfferModel.fromJson(item as Map<String, dynamic>).toEntity(),
          )
          .toList();
      return Right(resultsList);
    } on DioException catch (e) {
      return Left(NetworkHandler.handleDioException(e));
    }
  }
}
