import '../../../../core/utils/result.dart';
import '../entities/category_entity.dart';
import '../repositories/category_repository.dart';

class GetAllCategoriesUseCase {
  final CategoryRepository repository;

  GetAllCategoriesUseCase(this.repository);

  Future<Result<List<CategoryEntity>>> call({
    required String storeId,
    int page = 1,
    int limit = 10,
  }) {
    return repository.getAllCategories(
      storeId: storeId,
      page: page,
      limit: limit,
    );
  }
}
