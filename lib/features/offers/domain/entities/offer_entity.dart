import 'package:equatable/equatable.dart';

class OfferEntity extends Equatable {
  final String id;
  final String? image;
  final String? note;
  final String? contentUrl;

  const OfferEntity({
    required this.id,
    required this.image,
    this.note,
    this.contentUrl,
  });

  @override
  List<Object?> get props => [id, image, note, contentUrl];
}
