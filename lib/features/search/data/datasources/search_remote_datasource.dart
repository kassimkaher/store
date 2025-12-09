import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../utils/injector/injector.dart';
import '../../../offers/data/models/offer_model.dart';
import '../../../products/data/models/product_model.dart';
import '../../domain/entities/search_result_entity.dart';

abstract class SearchRemoteDataSource {
  Future<Either<Failure, List<SearchResult>>> searchProducts({
    required String storeId,
    required String query,
    int page = 1,
    int limit = 20,
  });

  Future<Either<Failure, List<SearchResult>>> searchOffers({
    required String storeId,
    required String query,
    int page = 1,
    int limit = 20,
  });

  Future<Either<Failure, List<SearchResult>>> searchAll({
    required String storeId,
    required String query,
    int page = 1,
    int limit = 20,
  });
}

@LazySingleton(as: SearchRemoteDataSource)
class SearchRemoteDataSourceImpl implements SearchRemoteDataSource {
  @override
  Future<Either<Failure, List<SearchResult>>> searchProducts({
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
          response.data['status'] == 'success') {
        final List<dynamic> productsData = response.data['data']['data'] ?? [];
        final products = productsData
            .map((json) => ProductModel.fromJson(json))
            .toList();

        return Right(
          products
              .map(
                (product) => SearchResult(
                  id: product.id,
                  title: product.name,
                  description: product.description,
                  image: product.image,
                  price: product.price,
                  type: SearchResultType.product,
                  categoryName: product.categoryName,
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

  @override
  Future<Either<Failure, List<SearchResult>>> searchOffers({
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
                (offer) => SearchResult(
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

  @override
  Future<Either<Failure, List<SearchResult>>> searchAll({
    required String storeId,
    required String query,
    int page = 1,
    int limit = 20,
  }) async {
    // Search both products and offers concurrently
    final results = await Future.wait([
      searchProducts(storeId: storeId, query: query, page: page, limit: 10),
      searchOffers(storeId: storeId, query: query, page: page, limit: 10),
    ]);

    // Combine both results
    return results[0].flatMap((productResults) {
      return results[1].map((offerResults) {
        final allResults = [...productResults, ...offerResults];
        return allResults.take(limit).toList();
      });
    });
  }
}
