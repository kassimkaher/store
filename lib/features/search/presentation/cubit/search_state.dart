import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:store_web/features/products/domain/entities/product_entity.dart';

part 'search_state.freezed.dart';

@freezed
class SearchState with _$SearchState {
  const factory SearchState.initial() = SearchInitial;
  const factory SearchState.loading() = SearchLoading;
  const factory SearchState.loaded({
    required List<ProductEntity> results,
    required String query,
  }) = SearchLoaded;
  const factory SearchState.error(String message) = SearchError;
}
