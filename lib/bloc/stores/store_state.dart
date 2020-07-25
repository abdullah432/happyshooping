part of 'store_bloc.dart';

abstract class StoreState extends Equatable {
  const StoreState();
  @override
  List<Object> get props => [];
}

class InitialStoreState extends StoreState {}

class FetchingInProgress extends StoreState { }

class FetchStoresSuccess extends StoreState {
  //Each category is inside index of this list like at index one list of 'Near You' stores
  final filteredCategoriesList;
  const FetchStoresSuccess({@required this.filteredCategoriesList});

  @override
  List<Object> get props => [filteredCategoriesList];
}

class FetchStoresFail extends StoreState {
  final String error;
  const FetchStoresFail({@required this.error});

  @override
  List<Object> get props => [error];
}