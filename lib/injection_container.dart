import 'package:catalog_data/catalog_data.dart';
import 'package:core/core.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:catalog_domain/catalog_domain.dart';

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
