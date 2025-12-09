import 'package:bloc/bloc.dart';

import '../../domain/usecases/product_usecases.dart';
import 'product_detail_state.dart';

class ProductDetailCubit extends Cubit<ProductDetailState> {
  final GetProductDetailsUseCase getProductDetailsUseCase;
  final String storeId;

  ProductDetailCubit({
    required this.getProductDetailsUseCase,
    required this.storeId,
  }) : super(const ProductDetailState.initial());

  Future<void> loadProductDetails(String productId) async {
    emit(const ProductDetailState.loading());

    final result = await getProductDetailsUseCase(
      productId: productId,
      storeId: storeId,
    );

    result.fold(
      (failure) => emit(ProductDetailState.error(failure.message)),
      (product) => emit(ProductDetailState.loaded(product)),
    );
  }
}
