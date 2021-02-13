import 'package:catalog_domain/catalog_domain.dart';
import 'package:dartz/dartz.dart';
import 'package:core/core.dart';

abstract class CatalogRepository {
  Future<Either<Failure, List<CatalogItem>>> getCatalogItems();
}