import 'package:bloc/bloc.dart';

import '../../domain/usecases/offer_usecases.dart';
import 'offers_state.dart';

// Cubit
class OffersCubit extends Cubit<OffersState> {
  final GetOffersUseCase getOffersUseCase;
  final String storeId;

  OffersCubit({required this.getOffersUseCase, required this.storeId})
    : super(const OffersState.initial());

  Future<void> loadOffers({int page = 1, int limit = 10}) async {
    emit(const OffersState.loading());

    final result = await getOffersUseCase(
      storeId: storeId,
      page: page,
      limit: limit,
    );

    result.fold(
      (failure) => emit(OffersState.error(failure.message)),
      (offers) => emit(OffersState.loaded(offers)),
    );
  }

  void refresh() {
    loadOffers();
  }
}
