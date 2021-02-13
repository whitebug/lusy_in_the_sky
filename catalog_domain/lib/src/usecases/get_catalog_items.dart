import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:core/core.dart';
import 'package:catalog_domain/catalog_domain.dart';

class GetCatalogItems implements UseCase<List<CatalogItem>, NoParams> {
  final CatalogRepository repository;

  GetCatalogItems({@required this.repository});
  @override
  Future<Either<Failure, List<CatalogItem>>> call(NoParams params) async {
    return await repository.getCatalogItems();
  }
}