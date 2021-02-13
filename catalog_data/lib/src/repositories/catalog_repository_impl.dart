import 'package:catalog_data/src/datasources/datasources.dart';
import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:catalog_domain/catalog_domain.dart';
import 'package:meta/meta.dart';

class CatalogItemRepositoryImpl implements CatalogRepository {
  final CatalogItemsDataSource catalogItemsDataSource;
  final NetworkInfo networkInfo;

  CatalogItemRepositoryImpl({
    @required this.catalogItemsDataSource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<CatalogItem>>> getCatalogItems() async {
    if (await networkInfo.isConnected) {
      try {
        final items = await catalogItemsDataSource.getCatalogItemList();
        return Right(items);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}
