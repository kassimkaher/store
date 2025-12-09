import 'package:bloc/bloc.dart';
import 'package:store_web/features/auth/cubit/auth_cubit.dart';
import 'package:store_web/utils/injector/injector.dart';

import '../../domain/usecases/offer_usecases.dart';
import 'offers_state.dart';

// Cubit
class OffersCubit extends Cubit<OffersState> {
  final GetOffersUseCase getOffersUseCase;

  OffersCubit({required this.getOffersUseCase})
    : super(const OffersState.initial());

  Future<void> loadOffers({int page = 1, int limit = 10}) async {
    emit(const OffersState.loading());

    final result = await getOffersUseCase(
      storeId: getIt<AuthCubit>().currentAuthData?.storeId ?? '',
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
