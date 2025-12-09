import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/search_result_entity.dart';

part 'search_state.freezed.dart';

@freezed
class SearchState with _$SearchState {
  const factory SearchState.initial() = SearchInitial;
  const factory SearchState.loading() = SearchLoading;
  const factory SearchState.loaded({
    required List<SearchResult> results,
    required String query,
  }) = SearchLoaded;
  const factory SearchState.error(String message) = SearchError;
}
