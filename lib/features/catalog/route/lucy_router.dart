import 'package:auto_route/auto_route_annotations.dart';
import 'package:lusy_in_the_sky/features/catalog/pages/pages.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    MaterialRoute(page: CatalogPage, initial: true),
  ],
)
class $LucyRouter {}