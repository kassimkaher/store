import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'cart_client.g.dart';

@RestApi()
abstract class CartClient {
  factory CartClient(Dio dio, {String? baseUrl}) = _CartClient;

  @GET('/stores/cart/store_id/{storeId}')
  Future<HttpResponse> getMyCartOrders({
    @Path('storeId') required String storeId,
    @Query('page') int page = 1,
    @Query('limit') int limit = 20,
    @Query('status') String status = 'all',
  });

  @POST('/stores/cart/store_id/{storeId}')
  Future<HttpResponse> submitCart({
    @Path('storeId') required String storeId,
    @Body() required Map<String, dynamic> cartData,
  });
}
