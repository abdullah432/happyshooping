part of 'store_bloc.dart';

abstract class StoreEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchStores extends StoreEvent { }