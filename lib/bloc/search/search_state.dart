part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();
  
  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {}

class FetchSearchedDataSuccess extends SearchState {
  final searchedResult;
  const FetchSearchedDataSuccess({@required this.searchedResult});

  @override
  List<Object> get props => [searchedResult];
}

class FetchSearchedDataFail extends SearchState {
  final error;
  const FetchSearchedDataFail({@required this.error});

  @override
  List<Object> get props => [error];
}
