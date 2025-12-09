import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entities/category_entity.dart';
import '../../domain/repositories/category_repository.dart';
import '../datasources/category_remote_datasource.dart';

@LazySingleton(as: CategoryRepository)
class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryRemoteDataSource _dataSource;

  CategoryRepositoryImpl(this._dataSource);

  @override
  Future<Either<Failure, List<CategoryEntity>>> getAllCategories({
    required String storeId,
    int page = 1,
    int limit = 10,
  }) async {
    final result = await _dataSource.getAllCategories(
      storeId: storeId,
      page: page,
      limit: limit,
    );
    return result.fold((failure) => Left(failure), (data) => Right(data));
  }
}
