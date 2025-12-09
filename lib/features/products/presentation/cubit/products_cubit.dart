import 'package:bloc/bloc.dart';

import '../../domain/usecases/product_usecases.dart';
import 'products_state.dart';

// Most Purchased Cubit
class MostPurchasedCubit extends Cubit<MostPurchasedState> {
  final GetMostPurchasedUseCase getMostPurchasedUseCase;
  final String storeId;

  MostPurchasedCubit({
    required this.getMostPurchasedUseCase,
    required this.storeId,
  }) : super(const MostPurchasedState.initial());

  Future<void> loadProducts({int page = 1, int limit = 10}) async {
    emit(const MostPurchasedState.loading());

    final result = await getMostPurchasedUseCase(
      storeId: storeId,
      page: page,
      limit: limit,
    );

    result.fold(
      (failure) => emit(MostPurchasedState.error(failure.message)),
      (products) => emit(MostPurchasedState.loaded(products)),
    );
  }

  void refresh() {
    loadProducts();
  }
}

// Products by Category Cubit
class ProductsByCategoryCubit extends Cubit<ProductsByCategoryState> {
  final GetProductsByCategoryUseCase getProductsByCategoryUseCase;
  final String storeId;

  ProductsByCategoryCubit({
    required this.getProductsByCategoryUseCase,
    required this.storeId,
  }) : super(const ProductsByCategoryState.initial());

  Future<void> loadProducts({
    required String categoryId,
    int page = 1,
    int limit = 10,
  }) async {
    emit(const ProductsByCategoryState.loading());

    final result = await getProductsByCategoryUseCase(
      storeId: storeId,
      categoryId: categoryId,
      page: page,
      limit: limit,
    );

    result.fold(
      (failure) => emit(ProductsByCategoryState.error(failure.message)),
      (products) => emit(ProductsByCategoryState.loaded(products)),
    );
  }

  void refresh({required String categoryId}) {
    loadProducts(categoryId: categoryId);
  }
}
