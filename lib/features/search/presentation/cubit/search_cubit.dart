import 'package:bloc/bloc.dart';

import '../../domain/usecases/search_usecases.dart';
import 'search_state.dart';

// Cubit
class SearchCubit extends Cubit<SearchState> {
  final SearchAllUseCase searchAllUseCase;
  final String storeId;

  SearchCubit({required this.searchAllUseCase, required this.storeId})
    : super(const SearchState.initial());

  Future<void> search(String query) async {
    if (query.trim().isEmpty) {
      emit(const SearchState.initial());
      return;
    }

    emit(const SearchState.loading());

    final result = await searchAllUseCase(storeId: storeId, query: query);

    result.fold(
      (failure) => emit(SearchState.error(failure.message)),
      (results) => emit(SearchState.loaded(results: results, query: query)),
    );
  }

  void clear() {
    emit(const SearchState.initial());
  }
}
