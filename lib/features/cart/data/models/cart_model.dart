import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/cart_entity.dart';

part 'cart_model.g.dart';

@JsonSerializable()
class LocationMapModel {
  final String lat;
  final String lng;

  LocationMapModel({required this.lat, required this.lng});

  factory LocationMapModel.fromJson(Map<String, dynamic> json) =>
      _$LocationMapModelFromJson(json);

  Map<String, dynamic> toJson() => _$LocationMapModelToJson(this);

  LocationMap toEntity() {
    return LocationMap(lat: lat, lng: lng);
  }
}

@JsonSerializable()
class CartRequestModel {
  final List<String> products;
  final String note;
  final String deliveryReceiverType;
  final String receiverNumber;
  final String paymentMethod;
  final String address;
  final LocationMapModel locationMap;

  CartRequestModel({
    required this.products,
    required this.note,
    required this.deliveryReceiverType,
    required this.receiverNumber,
    required this.paymentMethod,
    required this.address,
    required this.locationMap,
  });

  factory CartRequestModel.fromJson(Map<String, dynamic> json) =>
      _$CartRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$CartRequestModelToJson(this);
}

@JsonSerializable()
class CartOrderProductModel {
  final String categoryName;
  final String name;
  final double price;
  final String? image;
  final int quantity;

  CartOrderProductModel({
    required this.categoryName,
    required this.name,
    required this.price,
    this.image,
    required this.quantity,
  });

  factory CartOrderProductModel.fromJson(Map<String, dynamic> json) =>
      _$CartOrderProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$CartOrderProductModelToJson(this);

  CartOrderProduct toEntity() {
    return CartOrderProduct(
      categoryName: categoryName,
      name: name,
      price: price,
      image: image,
      quantity: quantity,
    );
  }
}

@JsonSerializable()
class CartOrderModel {
  final String id;
  final String cartId;
  final String status;
  final String? note;
  final String? refuseReason;
  final String deliveryReceiverType;
  final String receiverNumber;
  final String paymentMethod;
  final String address;
  final LocationMapModel locationMap;
  final List<CartOrderProductModel> products;
  final DateTime? createdAt;

  CartOrderModel({
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

  factory CartOrderModel.fromJson(Map<String, dynamic> json) {
    // Map snake_case API fields to camelCase
    return CartOrderModel(
      id: json['_id'] as String,
      cartId: json['cart_id'] as String,
      status: json['status'] as String,
      note: json['note'] as String?,
      refuseReason: json['refuse_reason'] as String?,
      deliveryReceiverType: json['delivery_receiver_type'] as String,
      receiverNumber: json['receiver_number'] as String,
      paymentMethod: json['payment_method'] as String,
      address: json['address'] as String,
      locationMap: LocationMapModel.fromJson(
        json['location_map'] as Map<String, dynamic>,
      ),
      products: (json['products'] as List<dynamic>)
          .map(
            (item) =>
                CartOrderProductModel.fromJson(item as Map<String, dynamic>),
          )
          .toList(),
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() => _$CartOrderModelToJson(this);

  CartOrder toEntity() {
    return CartOrder(
      id: id,
      cartId: cartId,
      status: status,
      note: note,
      refuseReason: refuseReason,
      deliveryReceiverType: deliveryReceiverType,
      receiverNumber: receiverNumber,
      paymentMethod: paymentMethod,
      address: address,
      locationMap: locationMap.toEntity(),
      products: products.map((p) => p.toEntity()).toList(),
      createdAt: createdAt,
    );
  }
}
