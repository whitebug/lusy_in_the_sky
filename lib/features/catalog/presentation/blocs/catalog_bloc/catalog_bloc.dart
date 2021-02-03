import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:lusy_in_the_sky/core/error/failures.dart';
import 'package:lusy_in_the_sky/core/usecases/usecase.dart';
import 'package:lusy_in_the_sky/features/catalog/domain/usecases/get_catalog_items.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:lusy_in_the_sky/features/catalog/domain/entities/catalog_item.dart';

part 'catalog_event.dart';
part 'catalog_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String NETWORK_FAILURE_MESSAGE = 'Network Failure';

class CatalogBloc extends Bloc<CatalogEvent, CatalogState> {
  final GetCatalogItems _getCatalogItems;
  CatalogBloc({@required GetCatalogItems getCatalogItems})
      : assert(getCatalogItems != null),
        _getCatalogItems = getCatalogItems,
        super(CatalogInitial());

  @override
  Stream<CatalogState> mapEventToState(
    CatalogEvent event,
  ) async* {
    if (event is LoadingCatalogEvent) {
      yield CatalogLoadingState();
    } else if (event is GetCatalogItemListEvent) {
      yield* _mapGetCatalogItemListEventToState();
    }
  }

  Stream<CatalogState> _mapGetCatalogItemListEventToState() async* {
    final inputEither = await _getCatalogItems(NoParams());
    yield CatalogLoadingState();
    yield* inputEither.fold(
      (failure) async* {
        yield CatalogErrorState(error: _mapFailureToMessage(failure: failure));
      },
      (items) async* {
        yield GetCatalogItemListState(catalogItemList: items);
      },
    );
  }

  String _mapFailureToMessage({@required Failure failure}) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case NetworkFailure:
        return NETWORK_FAILURE_MESSAGE;
      default:
        return 'Unexpected error';
    }
  }
}
