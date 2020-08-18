part of 'storeslistbloc.dart';

abstract class StoresListState extends Equatable {
  const StoresListState();
  @override
  List<Object> get props => [];
}

class InitialStoreListState extends StoresListState {}

class FetchingInProgress extends StoresListState { }

class FetchStoresListSuccess extends StoresListState {
  //Each category is inside index of this list like at index one list of 'Near You' stores
  final storesList;
  const FetchStoresListSuccess({@required this.storesList});

  @override
  List<Object> get props => [storesList];
}

class FetchStoresListFail extends StoresListState {
  final String error;
  const FetchStoresListFail({@required this.error});

  @override
  List<Object> get props => [error];
}