part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();
  @override
  List<Object> get props => [];
}

class FetchProduct extends ProductEvent {
  final String storeID;
  const FetchProduct({@required this.storeID});

  @override
  List<Object> get props => [storeID];
}