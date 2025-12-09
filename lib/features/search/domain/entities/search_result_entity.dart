import 'package:equatable/equatable.dart';

class SearchResult extends Equatable {
  final String id;
  final String title;
  final String? description;
  final String? image;
  final double? price;
  final SearchResultType type;
  final String? categoryName;

  const SearchResult({
    required this.id,
    required this.title,
    this.description,
    this.image,
    this.price,
    required this.type,
    this.categoryName,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    image,
    price,
    type,
    categoryName,
  ];
}

enum SearchResultType { product, offer }
