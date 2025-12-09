import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../features/products/data/models/product_model.dart';

part 'products_client.g.dart';

@RestApi()
abstract class ProductsClient {
  factory ProductsClient(Dio dio, {String? baseUrl}) = _ProductsClient;

  @GET('/web/stores/products/store_id/{storeId}')
  Future<HttpResponse> getMostPurchased({
    @Path('storeId') required String storeId,
    @Query('page') int page = 1,
    @Query('limit') int limit = 20,
  });

  @GET('/web/stores/products/store_id/{storeId}')
  Future<HttpResponse> searchProducts({
    @Path('storeId') required String storeId,
    @Query('search') required String search,
    @Query('page') int page = 1,
    @Query('limit') int limit = 20,
  });
}
