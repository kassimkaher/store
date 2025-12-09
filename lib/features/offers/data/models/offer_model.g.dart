// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offer_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OfferModel _$OfferModelFromJson(Map<String, dynamic> json) => OfferModel(
      id: json['_id'] as String,
      image: json['image'] as String?,
      contentUrl: json['contentUrl'] as String?,
      note: json['note'] as String?,
    );

Map<String, dynamic> _$OfferModelToJson(OfferModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'image': instance.image,
      'contentUrl': instance.contentUrl,
      'note': instance.note,
    };
