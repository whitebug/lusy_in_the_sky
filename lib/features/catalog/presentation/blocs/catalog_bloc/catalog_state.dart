part of 'catalog_bloc.dart';

abstract class CatalogState extends Equatable {
  const CatalogState();
}

class CatalogInitial extends CatalogState {
  @override
  List<Object> get props => [];
}

class GetCatalogItemListState extends CatalogState {
  final List<CatalogItem> catalogItemList;

  GetCatalogItemListState({@required this.catalogItemList});

  @override
  List<Object> get props => [catalogItemList];
}

class CatalogLoadingState extends CatalogState {
  @override
  List<Object> get props => [];
}

class CatalogErrorState extends CatalogState {
  final String error;

  CatalogErrorState({@required this.error});

  @override
  List<Object> get props => [error];
}
