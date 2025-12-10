import 'package:fpdart/fpdart.dart';
import 'package:store_web/features/products/domain/entities/product_entity.dart';

import '../../../../core/error/failures.dart';
import '../entities/search_result_entity.dart';

abstract class SearchRepository {
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
