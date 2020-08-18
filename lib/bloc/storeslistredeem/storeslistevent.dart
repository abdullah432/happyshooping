part of 'storeslistbloc.dart';

abstract class StoresListEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchStoresList extends StoresListEvent { }