import 'package:equatable/equatable.dart';

class CartOrder extends Equatable {
  final String id;
  final String cartId;
  final String status;
  final String? note;
  final String? refuseReason;
  final String deliveryReceiverType;
  final String receiverNumber;
  final String paymentMethod;
  final String address;
  final LocationMap locationMap;
  final List<CartOrderProduct> products;
  final DateTime? createdAt;

  const CartOrder({
    required this.id,
    required this.cartId,
    required this.status,
    this.note,
    this.refuseReason,
    required this.deliveryReceiverType,
    required this.receiverNumber,
    required this.paymentMethod,
    required this.address,
    required this.locationMap,
    required this.products,
    this.createdAt,
  });

  @override
  List<Object?> get props => [
    id,
    cartId,
    status,
    note,
    refuseReason,
    deliveryReceiverType,
    receiverNumber,
    paymentMethod,
    address,
    locationMap,
    products,
    createdAt,
  ];
}

class CartOrderProduct extends Equatable {
  final String categoryName;
  final String name;
  final double price;
  final String? image;
  final int quantity;

  const CartOrderProduct({
    required this.categoryName,
    required this.name,
    required this.price,
    this.image,
    required this.quantity,
  });

  double get totalPrice => price * quantity;

  @override
  List<Object?> get props => [categoryName, name, price, image, quantity];
}

class CartRequest extends Equatable {
  final List<String> productIds;
  final String note;
  final String deliveryReceiverType;
  final String receiverNumber;
  final String paymentMethod;
  final String address;
  final LocationMap locationMap;

  const CartRequest({
    required this.productIds,
    required this.note,
    required this.deliveryReceiverType,
    required this.receiverNumber,
    required this.paymentMethod,
    required this.address,
    required this.locationMap,
  });

  @override
  List<Object?> get props => [
    productIds,
    note,
    deliveryReceiverType,
    receiverNumber,
    paymentMethod,
    address,
    locationMap,
  ];
}

class LocationMap extends Equatable {
  final String lat;
  final String lng;

  const LocationMap({required this.lat, required this.lng});

  @override
  List<Object?> get props => [lat, lng];
}
