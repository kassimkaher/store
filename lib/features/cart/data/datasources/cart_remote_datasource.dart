import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../core/network/network_handler.dart';
import '../../../../utils/injector/injector.dart';
import '../../domain/entities/cart_entity.dart';
import '../models/cart_model.dart';

abstract class CartRemoteDataSource {
  Future<Either<Failure, void>> submitCart({
    required String storeId,
    required List<String> productIds,
    required String note,
    required String deliveryReceiverType,
    required String receiverNumber,
    required String paymentMethod,
    required String address,
    required LocationMap locationMap,
  });
  Future<Either<Failure, List<CartOrderEntity>>> getMyCartOrders({
    required String storeId,
    int page = 1,
    int limit = 10,
    String status = 'all',
  });
}

@LazySingleton(as: CartRemoteDataSource)
class CartRemoteDataSourceImpl implements CartRemoteDataSource {
  @override
  Future<Either<Failure, void>> submitCart({
    required String storeId,
    required List<String> productIds,
    required String note,
    required String deliveryReceiverType,
    required String receiverNumber,
    required String paymentMethod,
    required String address,
    required LocationMap locationMap,
  }) async {
    try {
      final cartData = {
        "store_id": storeId,
        'note': note,
        'delivery_receiver_type': deliveryReceiverType,
        'receiver_number': receiverNumber,
        'payment_method': paymentMethod,
        'address': address,
        'location_map': {'lat': locationMap.lat, 'lng': locationMap.lng},
        'products': productIds,
      };
      log('Submitting cart data: ${jsonEncode(cartData)}');
      await getIt<DioClient>().instance().cart.submitCart(
        storeId: storeId,
        cartData: cartData,
      );
      return const Right(null);
    } on DioException catch (e) {
      return Left(NetworkHandler.handleDioException(e));
    }
  }

  @override
  Future<Either<Failure, List<CartOrderEntity>>> getMyCartOrders({
    required String storeId,
    int page = 1,
    int limit = 10,
    String status = 'all',
  }) async {
    try {
      final response = await getIt<DioClient>().instance().cart.getMyCartOrders(
        storeId: storeId,
        page: page,
        limit: limit,
        status: status,
      );
      final responseData = response.data as Map<String, dynamic>;
      final resultsList = (responseData['results']['data'] as List)
          .map(
            (item) => CartOrderModel.fromJson(
              item as Map<String, dynamic>,
            ).toEntity(responseData['r2_base_url'] as String),
          )
          .toList();
      return Right(resultsList);
    } on DioException catch (e) {
      return Left(NetworkHandler.handleDioException(e));
    }
  }
}
