import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../entities/cart_entity.dart';
import '../repositories/cart_repository.dart';

class GetMyCartOrdersUseCase {
  final CartRepository repository;

  GetMyCartOrdersUseCase(this.repository);

  Future<Either<Failure, List<CartOrder>>> call({
    required String storeId,
    int page = 1,
    int limit = 10,
    String status = 'all',
  }) {
    return repository.getMyCartOrders(
      storeId: storeId,
      page: page,
      limit: limit,
      status: status,
    );
  }
}

class SubmitCartUseCase {
  final CartRepository repository;

  SubmitCartUseCase(this.repository);

  Future<Either<Failure, void>> call({
    required String storeId,
    required List<String> productIds,
    required String note,
    required String deliveryReceiverType,
    required String receiverNumber,
    required String paymentMethod,
    required String address,
    required LocationMap locationMap,
  }) {
    return repository.submitCart(
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
}
