import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:store_web/features/products/domain/entities/product_entity.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../utils/injector/injector.dart';
import '../../../offers/data/models/offer_model.dart';
import '../../../products/data/models/product_model.dart';
import '../../domain/entities/search_result_entity.dart';

abstract class SearchRemoteDataSource {
  Future<Either<Failure, List<ProductEntity>>> searchProducts({
    required String storeId,
    required String query,
    int page = 1,
    int limit = 20,
  });

  Future<Either<Failure, List<SearchResultEntity>>> searchOffers({
    required String storeId,
    required String query,
    int page = 1,
    int limit = 20,
  });
}

@LazySingleton(as: SearchRemoteDataSource)
class SearchRemoteDataSourceImpl implements SearchRemoteDataSource {
  @override
  Future<Either<Failure, List<ProductEntity>>> searchProducts({
    required String storeId,
    required String query,
    int page = 1,
    int limit = 20,
  }) async {
    try {
      final response = await getIt<DioClient>()
          .instance()
          .products
          .searchProducts(
            storeId: storeId,
            search: query,
            page: page,
            limit: limit,
          );

      if (response.response.statusCode == 200 &&
          response.data['error'] == false) {
        final List<dynamic> productsData =
            response.data['results']['data'] ?? [];
        final products = productsData
            .map((json) => ProductModel.fromJson(json))
            .toList();

        return Right(
          products
              .map((product) => product.toEntity(response.data['r2_base_url']))
              .toList(),
        );
      } else {
        return Left(
          ServerFailure(
            message: response.data['message'] ?? 'Failed to search offers',
          ),
        );
      }
    } on DioException catch (e) {
      return Left(ServerFailure(message: e.message ?? 'Network error'));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<SearchResultEntity>>> searchOffers({
    required String storeId,
    required String query,
    int page = 1,
    int limit = 20,
  }) async {
    try {
      final response = await getIt<DioClient>().instance().offers.searchOffers(
        storeId: storeId,
        search: query,
        page: page,
        limit: limit,
      );

      if (response.response.statusCode == 200 &&
          response.data['status'] == 'success') {
        final List<dynamic> offersData = response.data['data']['data'] ?? [];
        final offers = offersData
            .map((json) => OfferModel.fromJson(json))
            .toList();

        return Right(
          offers
              .map(
                (offer) => SearchResultEntity(
                  id: offer.id,
                  title: offer.note ?? 'عرض خاص',
                  description: offer.note,
                  image: offer.image,
                  type: SearchResultType.offer,
                ),
              )
              .toList(),
        );
      } else {
        return Left(
          ServerFailure(
            message: response.data['message'] ?? 'Failed to search offers',
          ),
        );
      }
    } on DioException catch (e) {
      return Left(ServerFailure(message: e.message ?? 'Network error'));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
