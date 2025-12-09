import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'categories_client.g.dart';

@RestApi()
abstract class CategoriesClient {
  factory CategoriesClient(Dio dio, {String? baseUrl}) = _CategoriesClient;

  @GET('/stores/categories/store_id/{storeId}')
  Future<HttpResponse> getCategories({
    @Path('storeId') required String storeId,
    @Query('page') int page = 1,
    @Query('limit') int limit = 20,
  });
}
