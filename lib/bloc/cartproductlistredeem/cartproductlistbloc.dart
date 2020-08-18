import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happyshooping/models/product.dart';
import 'package:happyshooping/repositories/cart_repository.dart';
import 'package:happyshooping/repositories/product_repository.dart';
import 'package:meta/meta.dart';

part 'cartproductlistevent.dart';
part 'cartproductliststate.dart';

class CartProductsListBloc
    extends Bloc<CartProductsListEvent, CartProductsListState> {
  CartProductsListBloc() : super(InitialCartProductsListState());

  final ProductRepository productRepository = ProductRepository();
  final CartRepository cartRepository = CartRepository();
  //
  List<bool> checked = List<bool>();
  List<Product> productsList;
  //cashback count
  int collectCashback = 0;
  List<String> products = List();

  @override
  Stream<CartProductsListState> mapEventToState(
      CartProductsListEvent event) async* {
    if (event is FetchCartProductsList) {
      yield FetchingInProgress();
      try {
        //first update data of cart model class
        await cartRepository.loadUserCart();
        productsList = await productRepository.loadListOfProductInUserCart();
        //initialize checked according to productsList
        for (int i = 0; i < productsList.length; i++) {
          checked.add(false);
        }
        //
        yield FetchCartProductsListSuccess(
            productsList: productsList, checked: checked);
      } on SocketException catch (error) {
        print("StoresListFetchStoresEvent: " + error.toString());
        yield FetchCartProductsListFail(
            error: "Connection Failed. Please check Your Internet connection");
      } catch (error) {
        print("StoresListFetchStoresEvent: " + error.toString());
        yield FetchCartProductsListFail(
            error: 'Fail to laod data. Please try again\nOr Report the issue');
      }
    }
    if (event is CheckBoxClicked) {
      //make list of products id. 
      //so if user clicked on collectcashback so we can send selected products id to database
      if (checked[event.index]) {
        checked[event.index] = false;
        collectCashback = collectCashback - productsList[event.index].cashback;
        products.remove(productsList[event.index].id);
      }else {
        checked[event.index] = true;
        collectCashback = collectCashback + productsList[event.index].cashback;
        products.add(productsList[event.index].id);
      }

      yield CheckedBoxClickedHappened(
          productsList: productsList, checked: checked, collectCashback: collectCashback, products: products);
    }
  }
}
