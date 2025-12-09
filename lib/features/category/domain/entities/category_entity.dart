import 'package:equatable/equatable.dart';

class CategoryEntity extends Equatable {
  final String id;
  final String name;
  final String? description;
  final String? image;
  final int? itemCount;
  final String? contentUrl;

  const CategoryEntity({
    required this.id,
    required this.name,
    this.description,
    this.image,
    this.itemCount,
    this.contentUrl,
  });

  @override
  List<Object?> get props => [id, name, description, image, itemCount];
}
