import 'package:catalog_domain/catalog_domain.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'catalog_item_model.g.dart';

@JsonSerializable()
class CatalogItemModel extends CatalogItem {
  @JsonKey(nullable: true)
  final int id;
  @JsonKey(nullable: true)
  final String name;
  @JsonKey(nullable: true)
  final String price;
  @JsonKey(nullable: true)
  final String special;
  @JsonKey(nullable: true)
  final String image;
  @JsonKey(nullable: true)
  final String regularVideo;
  @JsonKey(nullable: true)
  final String regularVideoPoster;
  @JsonKey(nullable: true)
  final String sizes;

  CatalogItemModel({
    @required this.id,
    @required this.name,
    @required this.price,
    @required this.special,
    @required this.image,
    @required this.regularVideo,
    @required this.regularVideoPoster,
    @required this.sizes,
  });

  factory CatalogItemModel.fromJson(Map<String, dynamic> json) =>
      _$CatalogItemModelFromJson(json);
  Map<String, dynamic> toJson() => _$CatalogItemModelToJson(this);

  static List<CatalogItemModel> fromJsonToList(dynamic data) {
    return (data as List)
        ?.map((e) => e == null
        ? null
        : CatalogItemModel.fromJson(e as Map<String, dynamic>))
        ?.toList();
  }

  static String get storageKey {
    return 'catalog_item_model';
  }
}