import 'package:dartz/dartz.dart';
import 'package:lusy_in_the_sky/core/error/exceptions.dart';
import 'package:lusy_in_the_sky/core/error/failures.dart';
import 'package:lusy_in_the_sky/core/network/network_info.dart';
import 'package:lusy_in_the_sky/features/catalog/data/datasources/catalog_items_datasource.dart';
import 'package:lusy_in_the_sky/features/catalog/domain/entities/catalog_item.dart';
import 'package:lusy_in_the_sky/features/catalog/domain/repositories/catalog_repository.dart';
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
