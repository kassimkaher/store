import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'offers_client.g.dart';

@RestApi()
abstract class OffersClient {
  factory OffersClient(Dio dio, {String? baseUrl}) = _OffersClient;

  @GET('/stores/offers/store_id/{storeId}')
  Future<HttpResponse> getOffers({
    @Path('storeId') required String storeId,
    @Query('page') int page = 1,
    @Query('limit') int limit = 20,
  });

  @GET('/stores/offers/store_id/{storeId}')
  Future<HttpResponse> searchOffers({
    @Path('storeId') required String storeId,
    @Query('search') required String search,
    @Query('page') int page = 1,
    @Query('limit') int limit = 20,
  });
}
