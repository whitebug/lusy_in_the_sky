import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:lusy_in_the_sky/core/error/failures.dart';
import 'package:lusy_in_the_sky/core/usecases/usecase.dart';
import 'package:lusy_in_the_sky/features/catalog/domain/entities/catalog_item.dart';
import 'package:lusy_in_the_sky/features/catalog/domain/repositories/catalog_repository.dart';

class GetCatalogItems implements UseCase<List<CatalogItem>, NoParams> {
  final CatalogRepository repository;

  GetCatalogItems({@required this.repository});
  @override
  Future<Either<Failure, List<CatalogItem>>> call(NoParams params) async {
    return await repository.getCatalogItems();
  }
}