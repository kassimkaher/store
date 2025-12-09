import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/offer_entity.dart';

part 'offers_state.freezed.dart';

@freezed
class OffersState with _$OffersState {
  const factory OffersState.initial() = OffersInitial;
  const factory OffersState.loading() = OffersLoading;
  const factory OffersState.loaded(List<OfferEntity> offers) = OffersLoaded;
  const factory OffersState.error(String message) = OffersError;
}
