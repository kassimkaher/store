import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../entities/product_entity.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<ProductEntity>>> getMostPurchased({
    required String storeId,
    int page = 1,
    int limit = 10,
  });

  Future<Either<Failure, ProductEntity>> getProductDetails({
    required String storeId,
    required String productId,
  });

  Future<Either<Failure, List<ProductEntity>>> getProductsByCategory({
    required String storeId,
    required String categoryId,
    int page = 1,
    int limit = 10,
  });
}
