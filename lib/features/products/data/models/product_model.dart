import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/product_entity.dart';

part 'product_model.g.dart';

@JsonSerializable()
class ProductModel {
  @JsonKey(name: '_id')
  final String id;
  final String name;
  final double price;
  final String? description;
  final String? image;
  final String? categoryId;
  final String? categoryName;
  final bool? isLiked;

  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    this.description,
    this.image,
    this.categoryId,
    this.categoryName,
    this.isLiked,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);

  ProductEntity toEntity([String? baseUrl]) {
    return ProductEntity(
      id: id,
      name: name,
      price: price,
      description: description,
      image: image,
      categoryId: categoryId,
      categoryName: categoryName,
      isLiked: isLiked,
      baseUrl: baseUrl,
    );
  }
}
