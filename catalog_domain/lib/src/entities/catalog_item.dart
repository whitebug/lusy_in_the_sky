import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class CatalogItem extends Equatable {
  final int id;
  final String name;
  final String price;
  final String special;
  final String image;
  final String regularVideo;
  final String regularVideoPoster;
  final String sizes;

  CatalogItem({
    @required this.id,
    @required this.name,
    @required this.price,
    @required this.special,
    @required this.image,
    @required this.regularVideo,
    @required this.regularVideoPoster,
    @required this.sizes,
  });

  @override
  List<Object> get props => [
        id,
        name,
        price,
        special,
        image,
        regularVideo,
        regularVideoPoster,
        sizes,
      ];
}
