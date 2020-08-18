part of 'cartproductlistbloc.dart';

abstract class CartProductsListState extends Equatable {
  const CartProductsListState();
  @override
  List<Object> get props => [];
}

class InitialCartProductsListState extends CartProductsListState {}

class FetchingInProgress extends CartProductsListState { }

class FetchCartProductsListSuccess extends CartProductsListState {
  //Each category is inside index of this list like at index one list of 'Near You' stores
  final productsList;
  final checked;
  const FetchCartProductsListSuccess({@required this.productsList, @required this.checked});

  @override
  List<Object> get props => [productsList, checked];
}

class FetchCartProductsListFail extends CartProductsListState {
  final String error;
  const FetchCartProductsListFail({@required this.error});

  @override
  List<Object> get props => [error];
}

class CheckedBoxClickedHappened extends CartProductsListState {
  //Each category is inside index of this list like at index one list of 'Near You' stores
  final productsList;
  final checked;
  final collectCashback;
  const CheckedBoxClickedHappened({@required this.productsList, @required this.checked, @required this.collectCashback,});

  @override
  List<Object> get props => [productsList, checked, collectCashback];
}