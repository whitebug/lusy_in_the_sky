import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:catalog_data/catalog_data.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

class MockCatalogItemsDataSource extends Mock
    implements CatalogItemsDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  CatalogItemRepositoryImpl repository;
  MockCatalogItemsDataSource mockCatalogItemsDataSource;
  MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockCatalogItemsDataSource = MockCatalogItemsDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = CatalogItemRepositoryImpl(
      catalogItemsDataSource: mockCatalogItemsDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  void runTestOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      body();
    });
  }

  void runTestOffline(Function body) {
    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });
      body();
    });
  }

  group('getCatalogItems', () {
    final CatalogItemModel tCatalogItemModel = CatalogItemModel(
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
    final List<CatalogItemModel> tCatalogItemList = [
      tCatalogItemModel,
      tCatalogItemModel,
    ];

    test(
      'should check if devise is online',
      () async {
        // arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        // act
        repository.getCatalogItems();
        // assert
        verify(mockNetworkInfo.isConnected);
      },
    );

    runTestOnline(() {
      test(
        'should return remote data'
        'when the call to remote data source is successful',
        () async {
          // arrange
          when(mockCatalogItemsDataSource.getCatalogItemList())
              .thenAnswer((_) async => tCatalogItemList);
          // act
          final result = await repository.getCatalogItems();
          // assert
          verify(mockCatalogItemsDataSource.getCatalogItemList());
          expect(result, equals(Right(tCatalogItemList)));
        },
      );

      test(
        'should return server failure'
        'when the call to remote data source is unsuccessful',
        () async {
          // arrange
          when(mockCatalogItemsDataSource.getCatalogItemList())
              .thenThrow(ServerException());
          // act
          final result = await repository.getCatalogItems();
          // assert
          verify(mockCatalogItemsDataSource.getCatalogItemList());
          expect(result, equals(Left(ServerFailure())));
        },
      );
    });

    runTestOffline(() {
      test(
        'should return [NetworkFailure] when network is not available',
        () async {
          // arrange
          when(mockCatalogItemsDataSource.getCatalogItemList())
              .thenThrow((_) async => Left(NetworkException()));
          // act
          final result = await repository.getCatalogItems();
          // assert
          expect(result, equals(Left(NetworkFailure())));
        },
      );
    });
  });
}
