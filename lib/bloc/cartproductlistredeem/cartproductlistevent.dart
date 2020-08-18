part of 'cartproductlistbloc.dart';

abstract class CartProductsListEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchCartProductsList extends CartProductsListEvent { }

class CheckBoxClicked extends CartProductsListEvent { 
  final index;
  CheckBoxClicked({@required this.index});
  @override
  List<Object> get props => [index];
}