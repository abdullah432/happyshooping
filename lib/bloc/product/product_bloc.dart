import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happyshooping/models/cart.dart';
import 'package:happyshooping/models/product.dart';
import 'package:happyshooping/models/user.dart';
import 'package:happyshooping/repositories/cart_repository.dart';
import 'package:happyshooping/repositories/product_repository.dart';
import 'package:happyshooping/repositories/user_repository.dart';
import 'package:meta/meta.dart';

part 'product_state.dart';
part 'product_event.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitialState());

  var listOfProduct;
  final ProductRepository _productRepository = ProductRepository();
  final CartRepository _cartRepository = CartRepository();
  //cart and user both is singleton
  final User _user = User();
  Cart cart = Cart();
  //Without any change the Widget will not be recreated.
  //In this case change is happening in sigleton class which program is not able to find
  //that's why count is use: BAD practice
  int count = 0;

  @override
  Stream<ProductState> mapEventToState(ProductEvent event) async* {
    if (event is FetchProduct) {
      yield ProductFetchInProgress();
      try {
        listOfProduct =
            await _productRepository.loadProductsWithId(id: event.storeID);
        //before displaying listOfProduct we should also know is that in user cart or not
        await _cartRepository.loadUserCart(id: _user.id);
        print(cart.toString());
        //Cart does not need to be pass because it's singleton. Directly access from ProductListState class
        yield ProductFetchSuccess(listOfProduct: listOfProduct);
      } catch (error) {
        print('ProductFetchFail exception: '+error.toString());
        yield ProductFetchFail(error: error.message);
      }
    }
    if (event is AddToCart) {
      try {
        String result = await _cartRepository.callCartListner(productID: event.productid);
        if (result != 'Success')
          yield AddToCartFail(error: result);
        else
          yield AddToCartSuccess(listOfProduct: listOfProduct, count: count++);
      }catch(error) {
        yield AddToCartFail(error: error.message);
      }
    }
  }
}
