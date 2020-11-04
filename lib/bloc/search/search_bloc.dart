import 'dart:async';
import 'dart:io';
import 'package:happyshooping/repositories/search_repository.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial());

  SearchRepository _searchRepository = SearchRepository();
  List<Object> listOfData = List();

  //just to reload search ui
  int count = 0;

  @override
  Stream<SearchState> mapEventToState(SearchEvent event) async* {
    try {
      if (event is SearchUserQuery) {
        listOfData = await _searchRepository.searchMyText(
            searchedText: event.searchText);
        yield FetchSearchedDataSuccess(searchedResult: listOfData, count: count++);
      }
    } on SocketException catch (_) {
      yield FetchSearchedDataFail(
          error: "Connection Failed. Please check Your Internet connection");
    } catch (error) {
      print(error);
      yield FetchSearchedDataFail(
        // error: 'Fail to laod data. Please try again\nOr Report the issue'
        error: error.toString(),
      );
    }
  }
}
