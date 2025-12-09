import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/offer_entity.dart';

part 'offer_model.g.dart';

@JsonSerializable()
class OfferModel {
  @JsonKey(name: '_id')
  final String id;
  final String? image;
  final String? contentUrl;
  final String? note;

  OfferModel({
    required this.id,
    required this.image,
    required this.contentUrl,
    this.note,
  });

  factory OfferModel.fromJson(Map<String, dynamic> json) =>
      _$OfferModelFromJson(json);

  Map<String, dynamic> toJson() => _$OfferModelToJson(this);

  OfferEntity toEntity() {
    return OfferEntity(
      id: id,
      image: image,
      contentUrl: contentUrl,
      note: note,
    );
  }
}
