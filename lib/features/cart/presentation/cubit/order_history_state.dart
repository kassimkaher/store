import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/cart_entity.dart';

part 'order_history_state.freezed.dart';

@freezed
class OrderHistoryState with _$OrderHistoryState {
  const factory OrderHistoryState.initial() = OrderHistoryInitial;
  const factory OrderHistoryState.loading() = OrderHistoryLoading;
  const factory OrderHistoryState.loaded(List<CartOrder> orders) =
      OrderHistoryLoaded;
  const factory OrderHistoryState.error(String message) = OrderHistoryError;
}
