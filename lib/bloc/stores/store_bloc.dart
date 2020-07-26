import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happyshooping/repositories/store_repository.dart';
import 'package:meta/meta.dart';

part 'store_event.dart';
part 'store_state.dart';

class StoreBloc extends Bloc<StoreEvent, StoreState> {
  StoreBloc() : super(InitialStoreState());

  final StoreRepository storeRepository = StoreRepository();

  @override
  Stream<StoreState> mapEventToState(StoreEvent event) async* {
    if (event is FetchStores) {
      yield FetchingInProgress();
      try {
        final storesList = await storeRepository.loadStores();
        //In home page i need filteredCategories to populate list of stores according to category
        //instead of list of stores
        final filteredCategories = storeRepository.filteredCategories(storesList);
        
        yield FetchStoresSuccess(filteredCategoriesList: filteredCategories);
      } on SocketException catch(_) {
        yield FetchStoresFail(error: "Connection Failed. Please check Your Internet connection");
      }
       catch (error) {
        print(error);
        yield FetchStoresFail(error: 'Fail to laod data. Please try again\nOr Report the issue');
      }
    }
  }
}
