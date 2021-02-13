import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:core/core.dart';
import 'package:catalog_domain/catalog_domain.dart';
import 'package:lusy_in_the_sky/features/catalog/blocs/catalog_bloc/catalog_bloc.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';

class MockGetCatalogItems extends Mock implements GetCatalogItems {}

void main() {
  // ignore: close_sinks
  CatalogBloc bloc;
  MockGetCatalogItems mockGetCatalogItems;

  setUp(() {
    mockGetCatalogItems = MockGetCatalogItems();
    bloc = CatalogBloc(getCatalogItems: mockGetCatalogItems);
  });

  test('initialState should be Empty', () {
    // assert
    expect(bloc.state, equals(CatalogInitial()));
  });

  group('GetCatalogItems', () {
    CatalogItem tCatalogItem = CatalogItem(
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
    CatalogItem tCatalogItem1 = CatalogItem(
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

    List<CatalogItem> tCatalogItemList = [tCatalogItem, tCatalogItem1];

    test('should get data from GetCatalogItems use case', () async {
      // arrange
      when(mockGetCatalogItems(any))
          .thenAnswer((_) async => Right(tCatalogItemList));
      // act
      bloc.add(GetCatalogItemListEvent());
      await untilCalled(mockGetCatalogItems(any));
      // assert
      verify(mockGetCatalogItems(NoParams()));
    });

    blocTest(
      'should emit [TvChannelLoadingState, GetTvChannelsListState] '
      'when data is gotten successfully',
      build: () {
        when(mockGetCatalogItems(any)).thenAnswer(
          (_) async => Right(tCatalogItemList),
        );
        return bloc;
      },
      act: (thisBloc) => thisBloc.add(
        GetCatalogItemListEvent(),
      ),
      expect: [
        CatalogLoadingState(),
        GetCatalogItemListState(catalogItemList: tCatalogItemList),
      ],
    );

    blocTest(
      'should emit [CatalogLoadingState, CatalogErrorState] '
      'when server failure occurs',
      build: () {
        when(mockGetCatalogItems(any)).thenAnswer(
          (_) async => Left(
            ServerFailure(),
          ),
        );
        return bloc;
      },
      act: (thisBloc) => thisBloc.add(
        GetCatalogItemListEvent(),
      ),
      expect: [
        CatalogLoadingState(),
        CatalogErrorState(error: SERVER_FAILURE_MESSAGE),
      ],
    );

    blocTest(
      'should emit [CatalogLoadingState, CatalogErrorState] '
      'when network failure occurs',
      build: () {
        when(mockGetCatalogItems(any))
            .thenAnswer((_) async => Left(NetworkFailure()));
        return bloc;
      },
      act: (thisBloc) => thisBloc.add(
        GetCatalogItemListEvent(),
      ),
      expect: [
        CatalogLoadingState(),
        CatalogErrorState(error: NETWORK_FAILURE_MESSAGE),
      ],
    );
  });
}
