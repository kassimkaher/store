import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entities/offer_entity.dart';
import '../../domain/repositories/offer_repository.dart';
import '../datasources/offer_remote_datasource.dart';

@LazySingleton(as: OfferRepository)
class OfferRepositoryImpl implements OfferRepository {
  final OfferRemoteDataSource _dataSource;

  OfferRepositoryImpl(this._dataSource);

  @override
  Future<Either<Failure, List<OfferEntity>>> getOffers({
    required String storeId,
    int page = 1,
    int limit = 10,
  }) async {
    final result = await _dataSource.getOffers(
      storeId: storeId,
      page: page,
      limit: limit,
    );
    return result.fold((failure) => Left(failure), (data) => Right(data));
  }

  @override
  Future<Either<Failure, List<OfferEntity>>> searchOffers({
    required String storeId,
    required String search,
    int page = 1,
    int limit = 10,
  }) async {
    final result = await _dataSource.searchOffers(
      storeId: storeId,
      search: search,
      page: page,
      limit: limit,
    );
    return result.fold((failure) => Left(failure), (data) => Right(data));
  }
}
