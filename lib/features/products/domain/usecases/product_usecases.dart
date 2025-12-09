import '../../../../core/utils/result.dart';
import '../entities/product_entity.dart';
import '../repositories/product_repository.dart';

class GetMostPurchasedUseCase {
  final ProductRepository repository;

  GetMostPurchasedUseCase(this.repository);

  Future<Result<List<ProductEntity>>> call({
    required String storeId,
    int page = 1,
    int limit = 10,
  }) {
    return repository.getMostPurchased(
      storeId: storeId,
      page: page,
      limit: limit,
    );
  }
}

class GetProductDetailsUseCase {
  final ProductRepository repository;

  GetProductDetailsUseCase(this.repository);

  Future<Result<ProductEntity>> call({
    required String storeId,
    required String productId,
  }) {
    return repository.getProductDetails(storeId: storeId, productId: productId);
  }
}

class GetProductsByCategoryUseCase {
  final ProductRepository repository;

  GetProductsByCategoryUseCase(this.repository);

  Future<Result<List<ProductEntity>>> call({
    required String storeId,
    required String categoryId,
    int page = 1,
    int limit = 10,
  }) {
    return repository.getProductsByCategory(
      storeId: storeId,
      categoryId: categoryId,
      page: page,
      limit: limit,
    );
  }
}
