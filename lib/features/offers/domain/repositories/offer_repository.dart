import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../entities/offer_entity.dart';

abstract class OfferRepository {
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
