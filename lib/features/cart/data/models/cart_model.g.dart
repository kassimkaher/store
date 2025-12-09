// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocationMapModel _$LocationMapModelFromJson(Map<String, dynamic> json) =>
    LocationMapModel(
      lat: json['lat'] as String,
      lng: json['lng'] as String,
    );

Map<String, dynamic> _$LocationMapModelToJson(LocationMapModel instance) =>
    <String, dynamic>{
      'lat': instance.lat,
      'lng': instance.lng,
    };

CartRequestModel _$CartRequestModelFromJson(Map<String, dynamic> json) =>
    CartRequestModel(
      products:
          (json['products'] as List<dynamic>).map((e) => e as String).toList(),
      note: json['note'] as String,
      deliveryReceiverType: json['deliveryReceiverType'] as String,
      receiverNumber: json['receiverNumber'] as String,
      paymentMethod: json['paymentMethod'] as String,
      address: json['address'] as String,
      locationMap: LocationMapModel.fromJson(
          json['locationMap'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CartRequestModelToJson(CartRequestModel instance) =>
    <String, dynamic>{
      'products': instance.products,
      'note': instance.note,
      'deliveryReceiverType': instance.deliveryReceiverType,
      'receiverNumber': instance.receiverNumber,
      'paymentMethod': instance.paymentMethod,
      'address': instance.address,
      'locationMap': instance.locationMap,
    };

CartOrderProductModel _$CartOrderProductModelFromJson(
        Map<String, dynamic> json) =>
    CartOrderProductModel(
      categoryName: json['categoryName'] as String,
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      image: json['image'] as String?,
      quantity: (json['quantity'] as num).toInt(),
    );

Map<String, dynamic> _$CartOrderProductModelToJson(
        CartOrderProductModel instance) =>
    <String, dynamic>{
      'categoryName': instance.categoryName,
      'name': instance.name,
      'price': instance.price,
      'image': instance.image,
      'quantity': instance.quantity,
    };

CartOrderModel _$CartOrderModelFromJson(Map<String, dynamic> json) =>
    CartOrderModel(
      id: json['id'] as String,
      cartId: json['cartId'] as String,
      status: json['status'] as String,
      note: json['note'] as String?,
      refuseReason: json['refuseReason'] as String?,
      deliveryReceiverType: json['deliveryReceiverType'] as String,
      receiverNumber: json['receiverNumber'] as String,
      paymentMethod: json['paymentMethod'] as String,
      address: json['address'] as String,
      locationMap: LocationMapModel.fromJson(
          json['locationMap'] as Map<String, dynamic>),
      products: (json['products'] as List<dynamic>)
          .map((e) => CartOrderProductModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$CartOrderModelToJson(CartOrderModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'cartId': instance.cartId,
      'status': instance.status,
      'note': instance.note,
      'refuseReason': instance.refuseReason,
      'deliveryReceiverType': instance.deliveryReceiverType,
      'receiverNumber': instance.receiverNumber,
      'paymentMethod': instance.paymentMethod,
      'address': instance.address,
      'locationMap': instance.locationMap,
      'products': instance.products,
      'createdAt': instance.createdAt?.toIso8601String(),
    };
