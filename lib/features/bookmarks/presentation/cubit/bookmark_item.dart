import 'package:equatable/equatable.dart';

import '../../../products/domain/entities/product_entity.dart';

class BookmarkItem extends Equatable {
  final ProductEntity product;
  final DateTime addedAt;

  const BookmarkItem({required this.product, required this.addedAt});

  Map<String, dynamic> toJson() {
    return {
      'product': {
        'id': product.id,
        'name': product.name,
        'price': product.price,
        'image': product.image,
        'description': product.description,
        'categoryId': product.categoryId,
        'categoryName': product.categoryName,
        'isLiked': product.isLiked,
        'baseUrl': product.baseUrl,
      },
      'addedAt': addedAt.toIso8601String(),
    };
  }

  factory BookmarkItem.fromJson(Map<String, dynamic> json) {
    final productData = json['product'] as Map<String, dynamic>;
    return BookmarkItem(
      product: ProductEntity(
        id: productData['id'] as String,
        name: productData['name'] as String,
        price: (productData['price'] as num).toDouble(),
        image: productData['image'] as String?,
        description: productData['description'] as String?,
        categoryId: productData['categoryId'] as String?,
        categoryName: productData['categoryName'] as String?,
        isLiked: productData['isLiked'] as bool?,
        baseUrl: productData['baseUrl'] as String?,
      ),
      addedAt: DateTime.parse(json['addedAt'] as String),
    );
  }

  @override
  List<Object?> get props => [product.id, addedAt];
}
