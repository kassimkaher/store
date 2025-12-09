import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../entities/cart_entity.dart';

abstract class CartRepository {
  Future<Either<Failure, void>> submitCart({
    required String storeId,
    required List<String> productIds,
    required String note,
    required String deliveryReceiverType,
    required String receiverNumber,
    required String paymentMethod,
    required String address,
    required LocationMap locationMap,
  });

  Future<Either<Failure, List<CartOrder>>> getMyCartOrders({
    required String storeId,
    int page = 1,
    int limit = 10,
    String status = 'all',
  });
}
