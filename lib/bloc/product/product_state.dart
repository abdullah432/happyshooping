part of 'product_bloc.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductInitialState extends ProductState { }

class ProductFetchInProgress extends ProductState { }

class ProductFetchSuccess extends ProductState {
  //Cart does not need to be pass because it's singleton. Directly access from ProductListState class
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

class AddToCartSuccess extends ProductState {
  //Cart does not need to be pass because it's singleton. Directly access from ProductListState class
  final List<Product> listOfProduct;
  final int count;
  const AddToCartSuccess({@required this.listOfProduct,@required this.count});

  @override
  List<Object> get props => [listOfProduct, count];
}

class AddToCartFail extends ProductState {
  final error;
  const AddToCartFail({@required this.error});

  @override
  List<Object> get props => [error];
}