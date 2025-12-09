import 'package:bloc/bloc.dart';
import 'package:store_web/features/auth/cubit/auth_cubit.dart';
import 'package:store_web/utils/injector/injector.dart';

import '../../domain/usecases/get_all_categories_usecase.dart';
import 'categories_state.dart';

// Cubit
class CategoriesCubit extends Cubit<CategoriesState> {
  final GetAllCategoriesUseCase getAllCategoriesUseCase;

  CategoriesCubit({required this.getAllCategoriesUseCase})
    : super(const CategoriesState.initial());

  Future<void> loadCategories({int page = 1, int limit = 10}) async {
    emit(const CategoriesState.loading());

    final result = await getAllCategoriesUseCase(
      storeId: getIt<AuthCubit>().currentAuthData?.storeId ?? '',
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
