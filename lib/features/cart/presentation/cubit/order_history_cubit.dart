import 'package:bloc/bloc.dart';

import '../../domain/usecases/cart_usecases.dart';
import 'order_history_state.dart';

class OrderHistoryCubit extends Cubit<OrderHistoryState> {
  final GetMyCartOrdersUseCase getMyCartOrdersUseCase;
  final String storeId;

  OrderHistoryCubit({
    required this.getMyCartOrdersUseCase,
    required this.storeId,
  }) : super(const OrderHistoryState.initial());

  Future<void> loadOrders({
    int page = 1,
    int limit = 10,
    String status = 'all',
  }) async {
    emit(const OrderHistoryState.loading());

    final result = await getMyCartOrdersUseCase(
      storeId: storeId,
      page: page,
      limit: limit,
      status: status,
    );

    result.fold(
      (failure) => emit(OrderHistoryState.error(failure.message)),
      (orders) => emit(OrderHistoryState.loaded(orders)),
    );
  }

  Future<void> refreshOrders() async {
    await loadOrders();
  }
}
