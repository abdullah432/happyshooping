part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class SearchUserQuery extends SearchEvent {
  final searchText;
  const SearchUserQuery({@required this.searchText});

  @override
  List<Object> get props => [searchText];
}