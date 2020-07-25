part of 'product_bloc.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductInitialState extends ProductState { }

class ProductFetchInProgress extends ProductState { }

class ProductFetchSuccess extends ProductState {
  final List<Product> listOfProduct;
  const ProductFetchSuccess({@required this.listOfProduct});

  @override
  List<Object> get props => [listOfProduct];
}

class ProductFetchFail extends ProductState {
  final error;
  const ProductFetchFail({@required this.error});

  @override
  List<Object> get props => [error];
}