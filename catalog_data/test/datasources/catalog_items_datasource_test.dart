import 'dart:convert';
import 'package:core/core.dart';
import 'package:catalog_data/catalog_data.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

import '../files/file_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  CatalogItemsDataSourceImpl dataSource;
  MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = CatalogItemsDataSourceImpl(client: mockHttpClient);
  });

  void setUpMockHttpClientSuccess200() {
    when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
            (_) async => http.Response(getFile('catalog.json'), 200));
  }

  void setUpMockHttpClientFailure404() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response('All wrong', 404));
  }

  group('getCatalogItemList', () {
    final tCatalogItemModel = CatalogItemModel.fromJsonToList(
      json.decode(
        getFile('catalog.json'),
      )['data'],
    );
    test(
        'should perform a GET request on URL '
            'with number being the endpoint and with application/json header', () {
      // arrange
      setUpMockHttpClientSuccess200();
      // act
      dataSource.getCatalogItemList();
      // assert
      verify(mockHttpClient.get(
        SERVER_URL+'/data.json',
        headers: {
          'Content-Type': 'application/json',
        },
      ));
    });

    test(
      'should return NumberTrivia when the response code is 200 (success)',
          () async {
        // arrange
        setUpMockHttpClientSuccess200();
        // act
        final result = await dataSource.getCatalogItemList();
        // assert
        expect(result, equals(tCatalogItemModel));
      },
    );

    test(
      'should throw a ServerException when the response code is 404 or other',
          () async {
        // arrange
        setUpMockHttpClientFailure404();
        // act
        final call = dataSource.getCatalogItemList;
        // assert
        expect(
              () => call(),
          throwsA(
            predicate((e) => e is ServerException),
          ),
        );
      },
    );
  });
}
