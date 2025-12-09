import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/category_entity.dart';

part 'category_model.g.dart';

@JsonSerializable()
class CategoryModel {
  @JsonKey(name: '_id')
  final String id;
  final String name;
  final String? description;
  final String? image;
  final int? itemCount;

  CategoryModel({
    required this.id,
    required this.name,
    this.description,
    this.image,
    this.itemCount,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);

  CategoryEntity toEntity([String? contentUrl]) {
    return CategoryEntity(
      id: id,
      name: name,
      description: description,
      image: image,
      itemCount: itemCount,
      contentUrl: contentUrl,
    );
  }
}
