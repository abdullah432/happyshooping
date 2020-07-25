import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happyshooping/models/product.dart';
import 'package:happyshooping/repositories/product_repository.dart';
import 'package:meta/meta.dart';

part 'product_state.dart';
part 'product_event.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitialState());

  final ProductRepository _productRepository = ProductRepository();

  @override
  Stream<ProductState> mapEventToState(ProductEvent event) async* {
    if (event is FetchProduct) {
      yield ProductFetchInProgress();
      try {
        final listOfProduct =
            await _productRepository.loadProductsWithId(id: event.storeID);
        yield ProductFetchSuccess(listOfProduct: listOfProduct);
      } catch (error) {
        print('ProductFetchFail exception: '+error.toString());
        yield ProductFetchFail(error: error.message);
      }
    }
  }
}
