import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lusy_in_the_sky/core/usecases/usecase.dart';
import 'package:lusy_in_the_sky/features/catalog/domain/entities/catalog_item.dart';
import 'package:lusy_in_the_sky/features/catalog/domain/repositories/catalog_repository.dart';
import 'package:lusy_in_the_sky/features/catalog/domain/usecases/get_catalog_items.dart';
import 'package:mockito/mockito.dart';

class MockCatalogRepository extends Mock implements CatalogRepository {}

void main() {
  GetCatalogItems usecase;
  MockCatalogRepository mockCatalogRepository;

  setUp(() {
    mockCatalogRepository = MockCatalogRepository();
    usecase = GetCatalogItems(repository: mockCatalogRepository);
  });

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
  final List<CatalogItem> tCatalogItems = [tCatalogItem, tCatalogItem];

  test('should return [List<CatalogItem>] when getCatalogItems is called',
      () async {
    // arrange
    when(
      mockCatalogRepository.getCatalogItems(),
    ).thenAnswer((_) async => Right(tCatalogItems));
    // act
    final result = await usecase(NoParams());
    // assert
    expect(result, Right(tCatalogItems));
    verify(mockCatalogRepository.getCatalogItems());
    verifyNoMoreInteractions(mockCatalogRepository);
  });
}
