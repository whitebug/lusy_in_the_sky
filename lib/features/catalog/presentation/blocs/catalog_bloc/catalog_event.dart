part of 'catalog_bloc.dart';

abstract class CatalogEvent extends Equatable {
  const CatalogEvent();
}

class GetCatalogItemListEvent extends CatalogEvent {
  @override
  List<Object> get props => [];
}

class LoadingCatalogEvent extends CatalogEvent {
  @override
  List<Object> get props => [];
}