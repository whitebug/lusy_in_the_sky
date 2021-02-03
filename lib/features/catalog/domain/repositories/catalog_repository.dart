import 'package:dartz/dartz.dart';
import 'package:lusy_in_the_sky/core/error/failures.dart';
import 'package:lusy_in_the_sky/features/catalog/domain/entities/catalog_item.dart';

abstract class CatalogRepository {
  Future<Either<Failure, List<CatalogItem>>> getCatalogItems();
}