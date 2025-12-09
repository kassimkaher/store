import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/product_entity.dart';

part 'products_state.freezed.dart';

@freezed
class MostPurchasedState with _$MostPurchasedState {
  const factory MostPurchasedState.initial() = MostPurchasedInitial;
  const factory MostPurchasedState.loading() = MostPurchasedLoading;
  const factory MostPurchasedState.loaded(List<ProductEntity> products) =
      MostPurchasedLoaded;
  const factory MostPurchasedState.error(String message) = MostPurchasedError;
}

@freezed
class ProductsByCategoryState with _$ProductsByCategoryState {
  const factory ProductsByCategoryState.initial() = ProductsByCategoryInitial;
  const factory ProductsByCategoryState.loading() = ProductsByCategoryLoading;
  const factory ProductsByCategoryState.loaded(List<ProductEntity> products) =
      ProductsByCategoryLoaded;
  const factory ProductsByCategoryState.error(String message) =
      ProductsByCategoryError;
}
