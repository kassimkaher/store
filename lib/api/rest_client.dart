import 'package:dio/dio.dart';

import 'cart/cart_client.dart';
import 'categories/categories_client.dart';
import 'offers/offers_client.dart';
import 'products/products_client.dart';

/// Store Web API Client
class RestClient {
  RestClient(Dio dio, {String? baseUrl}) : _dio = dio, _baseUrl = baseUrl;

  final Dio _dio;
  final String? _baseUrl;

  ProductsClient? _products;
  OffersClient? _offers;
  CategoriesClient? _categories;
  CartClient? _cart;

  ProductsClient get products =>
      _products ??= ProductsClient(_dio, baseUrl: _baseUrl);

  OffersClient get offers => _offers ??= OffersClient(_dio, baseUrl: _baseUrl);

  CategoriesClient get categories =>
      _categories ??= CategoriesClient(_dio, baseUrl: _baseUrl);

  CartClient get cart => _cart ??= CartClient(_dio, baseUrl: _baseUrl);
}
