import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'products_client.g.dart';

@RestApi()
abstract class ProductsClient {
  factory ProductsClient(Dio dio, {String? baseUrl}) = _ProductsClient;

  @GET('/stores/products/store_id/{storeId}/mostPurchased')
  Future<HttpResponse> getMostPurchased({
    @Path('storeId') required String storeId,
    @Query('page') int page = 1,
    @Query('limit') int limit = 20,
  });

  @GET('/stores/products/{productId}/store_id/{storeId}')
  Future<HttpResponse> getProductDetails({
    @Path('productId') required String productId,
    @Path('storeId') required String storeId,
  });

  @GET('/stores/products/store_id/{storeId}')
  Future<HttpResponse> getProductsByCategory({
    @Path('storeId') required String storeId,
    @Query('category_id') required String categoryId,
    @Query('page') int page = 1,
    @Query('limit') int limit = 20,
  });

  @GET('/stores/products/store_id/{storeId}')
  Future<HttpResponse> searchProducts({
    @Path('storeId') required String storeId,
    @Query('search') required String search,
    @Query('page') int page = 1,
    @Query('limit') int limit = 20,
  });
}
