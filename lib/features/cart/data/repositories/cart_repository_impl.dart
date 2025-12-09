import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entities/cart_entity.dart';
import '../../domain/repositories/cart_repository.dart';
import '../datasources/cart_remote_datasource.dart';

@LazySingleton(as: CartRepository)
class CartRepositoryImpl implements CartRepository {
  final CartRemoteDataSource _dataSource;

  CartRepositoryImpl(this._dataSource);

  @override
  Future<Either<Failure, void>> submitCart({
    required String storeId,
    required List<String> productIds,
    required String note,
    required String deliveryReceiverType,
    required String receiverNumber,
    required String paymentMethod,
    required String address,
    required LocationMap locationMap,
  }) async {
    return await _dataSource.submitCart(
      storeId: storeId,
      productIds: productIds,
      note: note,
      deliveryReceiverType: deliveryReceiverType,
      receiverNumber: receiverNumber,
      paymentMethod: paymentMethod,
      address: address,
      locationMap: locationMap,
    );
  }

  @override
  Future<Either<Failure, List<CartOrderEntity>>> getMyCartOrders({
    required String storeId,
    int page = 1,
    int limit = 10,
    String status = 'all',
  }) async {
    final result = await _dataSource.getMyCartOrders(
      storeId: storeId,
      page: page,
      limit: limit,
      status: status,
    );
    return result.fold((failure) => Left(failure), (data) => Right(data));
  }
}
