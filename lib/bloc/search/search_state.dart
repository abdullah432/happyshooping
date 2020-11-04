part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();
  
  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {}

class FetchSearchedDataSuccess extends SearchState {
  final searchedResult;
  //just reload ui
  final count;
  const FetchSearchedDataSuccess({@required this.searchedResult, @required this.count});

  @override
  List<Object> get props => [searchedResult, count];
}

class FetchSearchedDataFail extends SearchState {
  final error;
  const FetchSearchedDataFail({@required this.error});

  @override
  List<Object> get props => [error];
}
