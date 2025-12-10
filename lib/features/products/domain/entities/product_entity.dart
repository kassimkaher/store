import 'package:store_web/features/search/domain/entities/search_result_entity.dart';

class ProductEntity {
  final String id;
  final String name;
  final double price;
  final String? description;
  final String? image;
  final String? categoryId;
  final String? categoryName;
  final bool? isLiked;
  final String? baseUrl;
  final SearchResultType type;

  const ProductEntity({
    required this.id,
    required this.name,
    required this.price,
    this.description,
    this.image,
    this.categoryId,
    this.categoryName,
    this.isLiked,
    this.baseUrl,
    this.type = SearchResultType.product,
  });
}
