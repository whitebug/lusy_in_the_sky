// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:lusy_in_the_sky/features/catalog/pages/pages.dart';

class Routes {
  static const String catalogPage = '/';
  static const all = <String>{
    catalogPage,
  };
}

class LucyRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.catalogPage, page: CatalogPage),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    CatalogPage: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => CatalogPage(),
        settings: data,
      );
    },
  };
}
