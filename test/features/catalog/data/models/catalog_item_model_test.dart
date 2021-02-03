import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:lusy_in_the_sky/features/catalog/data/models/catalog_item_model.dart';
import 'package:lusy_in_the_sky/features/catalog/domain/entities/catalog_item.dart';

import '../../../../files/file_reader.dart';

void main() {
  CatalogItemModel tCatalogItemModel = CatalogItemModel(
    id: 52537,
    name: 'Neia Ruffle Dress in Blue Chiffon',
    price: '\$79.00',
    special: '\$59.25',
    image: 'https://media.lucyinthesky.com/data/Sep20_2/781A0417.JPG',
    regularVideo:
        'https://media.lucyinthesky.com/data/Sep20_2/781A0251_LOW.MP4',
    regularVideoPoster:
        'https://media.lucyinthesky.com/data/Sep20_2/781A0251_LOW.MP4.jpeg',
    sizes: 'L, M, S, XS',
  );
  CatalogItemModel tCatalogItemModel1 = CatalogItemModel(
    id: 52251,
    name: 'Neia Ruffle Dress in White Chiffon',
    price: '\$75.00',
    special: '\$56.25',
    image: 'https://media.lucyinthesky.com/data/Aug20_2/781A0219.JPG',
    regularVideo:
        'https://media.lucyinthesky.com/data/Aug20_2/781A0219_LOW.MP4',
    regularVideoPoster:
        'https://media.lucyinthesky.com/data/Aug20_2/781A0219_LOW.MP4.jpeg',
    sizes: 'L, M, S, XS',
  );

  List<CatalogItemModel> tCatalogItemList = [
    tCatalogItemModel,
    tCatalogItemModel1
  ];

  test('[CatalogItemModel] should be a subclass of [CatalogItem]', () async {
    expect(tCatalogItemModel, isA<CatalogItem>());
  });

  test('should return [CatalogItemModel] when valid json provided', () async {
    // arrange
    final Map<String, dynamic> jsonMap = json.decode(getFile('item.json'));
    // act
    final CatalogItemModel catalogItem = CatalogItemModel.fromJson(jsonMap);
    // assert
    expect(catalogItem, tCatalogItemModel);
  });

  test('should return valid json when [CatalogItemModel] provided', () async {
    // arrange
    final jsonMap = tCatalogItemModel.toJson();
    // act
    final Map<String, dynamic> decodedMap = json.decode(getFile('item.json'));
    // assert
    expect(decodedMap, jsonMap);
  });

  test('should return [List<CatalogItemModel>] when valid json provided',
      () async {
    // arrange
    final Map<String, dynamic> jsonListMap =
        json.decode(getFile('catalog.json'));
    // act
    final List<CatalogItemModel> catalogItemList =
        CatalogItemModel.fromJsonToList(jsonListMap['data']);
    // assert
    expect(catalogItemList, tCatalogItemList);
    //expect()
  });
}
