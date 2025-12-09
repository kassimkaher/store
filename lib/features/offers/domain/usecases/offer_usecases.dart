import 'package:injectable/injectable.dart';

import '../../../../core/utils/result.dart';
import '../entities/offer_entity.dart';
import '../repositories/offer_repository.dart';

@lazySingleton
class GetOffersUseCase {
  final OfferRepository repository;

  GetOffersUseCase(this.repository);

  Future<Result<List<OfferEntity>>> call({
    required String storeId,
    int page = 1,
    int limit = 10,
  }) {
    return repository.getOffers(storeId: storeId, page: page, limit: limit);
  }
}

@lazySingleton
class SearchOffersUseCase {
  final OfferRepository repository;

  SearchOffersUseCase(this.repository);

  Future<Result<List<OfferEntity>>> call({
    required String storeId,
    required String search,
    int page = 1,
    int limit = 10,
  }) {
    return repository.searchOffers(
      storeId: storeId,
      search: search,
      page: page,
      limit: limit,
    );
  }
}
