import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store_web/features/cart/domain/entities/cart_entity.dart';

import '../../../products/domain/entities/product_entity.dart';
import '../../domain/usecases/cart_usecases.dart';
import 'cart_item.dart';
import 'cart_state.dart';

@singleton
class CartCubit extends Cubit<CartState> {
  static const String _cartKey = 'cart_items';
  final SubmitCartUseCase submitCartUseCase;

  CartCubit(this.submitCartUseCase) : super(const CartState()) {
    _loadCart();
  }

  Future<void> _loadCart() async {
    emit(state.copyWith(isLoading: true));
    try {
      final prefs = await SharedPreferences.getInstance();
      final cartJson = prefs.getString(_cartKey);

      if (cartJson != null) {
        final List<dynamic> cartList = json.decode(cartJson);
        final items = cartList.map((item) => CartItem.fromJson(item)).toList();
        emit(state.copyWith(items: items, isLoading: false));
      } else {
        emit(state.copyWith(isLoading: false));
      }
    } catch (e) {
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> _saveCart() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cartJson = json.encode(
        state.items.map((item) => item.toJson()).toList(),
      );
      await prefs.setString(_cartKey, cartJson);
    } catch (e) {
      // Handle error
    }
  }

  void addToCart(ProductEntity product, {int quantity = 1}) {
    final existingIndex = state.items.indexWhere(
      (item) => item.product.id == product.id,
    );

    List<CartItem> updatedItems;
    if (existingIndex != -1) {
      // Product already exists, update quantity
      updatedItems = List.from(state.items);
      updatedItems[existingIndex] = updatedItems[existingIndex].copyWith(
        quantity: updatedItems[existingIndex].quantity + quantity,
      );
    } else {
      // Add new product
      updatedItems = [
        ...state.items,
        CartItem(product: product, quantity: quantity),
      ];
    }

    emit(state.copyWith(items: updatedItems));
    _saveCart();
  }

  void removeFromCart(String productId) {
    final updatedItems = state.items
        .where((item) => item.product.id != productId)
        .toList();
    emit(state.copyWith(items: updatedItems));
    _saveCart();
  }

  void updateQuantity(String productId, int quantity) {
    if (quantity <= 0) {
      removeFromCart(productId);
      return;
    }

    final updatedItems = state.items.map((item) {
      if (item.product.id == productId) {
        return item.copyWith(quantity: quantity);
      }
      return item;
    }).toList();

    emit(state.copyWith(items: updatedItems));
    _saveCart();
  }

  void incrementQuantity(String productId) {
    final item = state.items.firstWhere((item) => item.product.id == productId);
    updateQuantity(productId, item.quantity + 1);
  }

  void decrementQuantity(String productId) {
    final item = state.items.firstWhere((item) => item.product.id == productId);
    updateQuantity(productId, item.quantity - 1);
  }

  void clearCart() {
    emit(state.copyWith(items: []));
    _saveCart();
  }

  double get totalAmount {
    return state.items.fold(0, (sum, item) => sum + item.totalPrice);
  }

  int get itemCount {
    return state.items.fold(0, (sum, item) => sum + item.quantity);
  }

  Future<void> submitCart({
    required String storeId,
    required String address,
    String note = '',
    required String deliveryReceiverType,
    String receiverNumber = '',
    String paymentMethod = 'الدفع الالكتروني',
    double lat = 0.0,
    double lng = 0.0,
  }) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    try {
      final productIds = state.items.map((item) => item.product.id).toList();

      final result = await submitCartUseCase(
        storeId: storeId,
        productIds: productIds,
        note: note,
        deliveryReceiverType: deliveryReceiverType,
        receiverNumber: receiverNumber,
        paymentMethod: paymentMethod,
        address: address,
        locationMap: LocationMap(lat: lat.toString(), lng: lng.toString()),
      );

      result.fold(
        (failure) {
          emit(state.copyWith(isLoading: false, errorMessage: failure.message));
        },
        (_) {
          // Clear cart on success
          clearCart();
          emit(state.copyWith(isLoading: false, errorMessage: null));
        },
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }
}
