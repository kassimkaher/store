import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../entities/search_result_entity.dart';

abstract class SearchRepository {
  Future<Either<Failure, List<SearchResult>>> searchAll({
    required String storeId,
    required String query,
    int page = 1,
    int limit = 20,
  });

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
}
