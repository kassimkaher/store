import 'package:bloc/bloc.dart';

import '../../domain/usecases/get_all_categories_usecase.dart';
import 'categories_state.dart';

// Cubit
class CategoriesCubit extends Cubit<CategoriesState> {
  final GetAllCategoriesUseCase getAllCategoriesUseCase;
  final String storeId;

  CategoriesCubit({
    required this.getAllCategoriesUseCase,
    required this.storeId,
  }) : super(const CategoriesState.initial());

  Future<void> loadCategories({int page = 1, int limit = 10}) async {
    emit(const CategoriesState.loading());

    final result = await getAllCategoriesUseCase(
      storeId: storeId,
      page: page,
      limit: limit,
    );

    result.fold(
      (failure) => emit(CategoriesState.error(failure.message)),
      (categories) => emit(CategoriesState.loaded(categories)),
    );
  }

  void refresh() {
    loadCategories();
  }
}
