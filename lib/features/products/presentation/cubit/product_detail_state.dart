import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/product_entity.dart';

part 'product_detail_state.freezed.dart';

@freezed
class ProductDetailState with _$ProductDetailState {
  const factory ProductDetailState.initial() = ProductDetailInitial;
  const factory ProductDetailState.loading() = ProductDetailLoading;
  const factory ProductDetailState.loaded(ProductEntity product) =
      ProductDetailLoaded;
  const factory ProductDetailState.error(String message) = ProductDetailError;
}
