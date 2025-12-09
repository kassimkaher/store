import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../entities/search_result_entity.dart';
import '../repositories/search_repository.dart';

@lazySingleton
class SearchAllUseCase {
  final SearchRepository repository;

  SearchAllUseCase({required this.repository});

  Future<Either<Failure, List<SearchResult>>> call({
    required String storeId,
    required String query,
    int page = 1,
    int limit = 20,
  }) async {
    if (query.trim().isEmpty) {
      return const Right([]);
    }
    return await repository.searchAll(
      storeId: storeId,
      query: query,
      page: page,
      limit: limit,
    );
  }
}

@lazySingleton
class SearchProductsUseCase {
  final SearchRepository repository;

  SearchProductsUseCase({required this.repository});

  Future<Either<Failure, List<SearchResult>>> call({
    required String storeId,
    required String query,
    int page = 1,
    int limit = 20,
  }) async {
    if (query.trim().isEmpty) {
      return const Right([]);
    }
    return await repository.searchProducts(
      storeId: storeId,
      query: query,
      page: page,
      limit: limit,
    );
  }
}

@lazySingleton
class SearchOffersInResultsUseCase {
  final SearchRepository repository;

  SearchOffersInResultsUseCase({required this.repository});

  Future<Either<Failure, List<SearchResult>>> call({
    required String storeId,
    required String query,
    int page = 1,
    int limit = 20,
  }) async {
    if (query.trim().isEmpty) {
      return const Right([]);
    }
    return await repository.searchOffers(
      storeId: storeId,
      query: query,
      page: page,
      limit: limit,
    );
  }
}
