import 'package:equatable/equatable.dart';

import '../../../products/domain/entities/product_entity.dart';

class CartItem extends Equatable {
  final ProductEntity product;
  final int quantity;

  const CartItem({required this.product, this.quantity = 1});

  double get totalPrice => product.price * quantity;

  CartItem copyWith({ProductEntity? product, int? quantity}) {
    return CartItem(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
    );
  }

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
      'quantity': quantity,
    };
  }

  factory CartItem.fromJson(Map<String, dynamic> json) {
    final productData = json['product'] as Map<String, dynamic>;
    return CartItem(
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
      quantity: json['quantity'] as int,
    );
  }

  @override
  List<Object?> get props => [product.id, quantity];
}
