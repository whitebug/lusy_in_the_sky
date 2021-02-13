// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'catalog_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CatalogItemModel _$CatalogItemModelFromJson(Map<String, dynamic> json) {
  return CatalogItemModel(
    id: json['id'] as int,
    name: json['name'] as String,
    price: json['price'] as String,
    special: json['special'] as String,
    image: json['image'] as String,
    regularVideo: json['regularVideo'] as String,
    regularVideoPoster: json['regularVideoPoster'] as String,
    sizes: json['sizes'] as String,
  );
}

Map<String, dynamic> _$CatalogItemModelToJson(CatalogItemModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'price': instance.price,
      'special': instance.special,
      'image': instance.image,
      'regularVideo': instance.regularVideo,
      'regularVideoPoster': instance.regularVideoPoster,
      'sizes': instance.sizes,
    };
