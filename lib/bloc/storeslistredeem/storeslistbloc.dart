import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happyshooping/repositories/store_repository.dart';
import 'package:meta/meta.dart';

part 'storeslistevent.dart';
part 'storesliststate.dart';

class StoresListBloc extends Bloc<StoresListEvent, StoresListState> {
  StoresListBloc() : super(InitialStoreListState());

  final StoreRepository storeRepository = StoreRepository();

  @override
  Stream<StoresListState> mapEventToState(StoresListEvent event) async* {
    if (event is FetchStoresList) {
      yield FetchingInProgress();
      try {
        final storesList = await storeRepository.loadStores();
        
        yield FetchStoresListSuccess(storesList: storesList);
      } on SocketException catch(error) {
        print("StoresListFetchStoresEvent: "+error.message);
        yield FetchStoresListFail(error: "Connection Failed. Please check Your Internet connection");
      }
       catch (error) {
        print("StoresListFetchStoresEvent: "+error.message);
        yield FetchStoresListFail(error: 'Fail to laod data. Please try again\nOr Report the issue');
      }
    }
  }
}
