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
  });
}
