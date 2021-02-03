import 'dart:convert';

import 'package:lusy_in_the_sky/core/error/exceptions.dart';
import 'package:lusy_in_the_sky/features/catalog/data/models/catalog_item_model.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

const SERVER_URL = 'https://lucy-test1.s3.amazonaws.com';

abstract class CatalogItemsDataSource {
  /// Calls https://lucy-test1.s3.amazonaws.com/data.json
  ///
  /// Throws a [ServerException] for all error codes
  Future<List<CatalogItemModel>> getCatalogItemList();
}

class CatalogItemsDataSourceImpl implements CatalogItemsDataSource {
  final http.Client client;

  CatalogItemsDataSourceImpl({@required this.client});

  @override
  Future<List<CatalogItemModel>> getCatalogItemList() =>
      _getCatalogItemListFromUrl(SERVER_URL+'/data.json');

  Future<List<CatalogItemModel>> _getCatalogItemListFromUrl(String url) async {
    final response = await client.get(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return CatalogItemModel.fromJsonToList(json.decode(response.body)['data']);
    } else {
      throw ServerException();
    }
  }
}