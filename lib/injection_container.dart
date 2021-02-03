import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:lusy_in_the_sky/core/network/network_info.dart';
import 'package:lusy_in_the_sky/features/catalog/data/datasources/catalog_items_datasource.dart';
import 'package:lusy_in_the_sky/features/catalog/data/repositories/catalog_repository_impl.dart';
import 'package:lusy_in_the_sky/features/catalog/domain/repositories/catalog_repository.dart';
import 'package:lusy_in_the_sky/features/catalog/domain/usecases/get_catalog_items.dart';
import 'package:lusy_in_the_sky/features/catalog/presentation/blocs/lucy_bloc_observer.dart';

import 'features/catalog/presentation/blocs/catalog_bloc/catalog_bloc.dart';

final GetIt getIt = GetIt.I;

Future setup() async {
  // Features - TV Channel
  // Bloc
  getIt.registerFactory(
    () => CatalogBloc(getCatalogItems: getIt()),
  );
  // Use Cases
  getIt.registerLazySingleton(() => GetCatalogItems(repository: getIt()));
  // Repository
  getIt.registerLazySingleton<CatalogRepository>(
    () => CatalogItemRepositoryImpl(
      networkInfo: getIt(),
      catalogItemsDataSource: getIt(),
    ),
  );
  // Data sources
  getIt.registerLazySingleton<CatalogItemsDataSource>(
    () => CatalogItemsDataSourceImpl(
      client: getIt(),
    ),
  );
  // Core
  getIt.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(getIt()));
  // External
  getIt.registerLazySingleton(() => http.Client());
  getIt.registerLazySingleton(() => DataConnectionChecker());
}
