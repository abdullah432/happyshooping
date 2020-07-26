import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:happyshooping/UI/product_detail.dart';
import 'package:happyshooping/Utils/Constant.dart';
import 'package:happyshooping/models/cart.dart';
import 'package:happyshooping/models/product.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happyshooping/bloc/product/product_bloc.dart';

import '../common/circle_button.dart';

class ProductList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProductListState();
  }
}

class _ProductListState extends State<ProductList> {

  bool pInCartExists;
  List<Product> _listOfProduct = List();
  Cart _cart = Cart();

  ProductBloc _productBloc;

  @override
  Widget build(BuildContext context) {
    _productBloc = BlocProvider.of<ProductBloc>(context);
    return BlocListener<ProductBloc, ProductState>(listener: (context, state) {
      if (state is ProductFetchFail) {
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text(state.error),
          backgroundColor: Colors.red,
        ));
      }

      if (state is AddToCartFail) {
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text(state.error),
          backgroundColor: Colors.red,
        ));
      }
    }, child: BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
      if (state is ProductInitialState || state is ProductFetchInProgress) {
        return Center(child: SpinKitPulse(size: 51.0, color: Colors.green));
      }

      if (state is ProductFetchSuccess) {
        _listOfProduct = state.listOfProduct;
        return listOfProduct();
      }

      if (state is AddToCartSuccess) {
        _listOfProduct = state.listOfProduct;
        return listOfProduct();
      }

      if (state is ProductFetchFail) {
        return Container();
      }
    }));
  }

  listOfProduct() {
    print('happened');
    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: 4 / 5,
      children: List.generate(_listOfProduct.length, (index) {
        pInCartExists = inCart(_listOfProduct[index].id);
        return Stack(
          children: [
            GestureDetector(
              onTap: () =>
                  navigateToProductDetailPage(index, _listOfProduct[index]),
              child: Card(
                margin: const EdgeInsets.all(10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        flex: 3,
                        child: Center(
                          child: Hero(
                            tag: 'tag$index',
                            child: CachedNetworkImage(
                              imageUrl: _listOfProduct[index].imageUrl,
                              placeholder: (context, url) =>
                                  const SpinKitThreeBounce(
                                color: Colors.black,
                                size: 20.0,
                              ),
                              errorWidget: (context, url, error) => Icon(
                                Icons.error,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                          flex: 1,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Text(
                                      'Rs. ${_listOfProduct[index].cashback}  cashback',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      )),
                                ),
                                Flexible(
                                  child: Text(
                                    'Rs. ${_listOfProduct[index].totalPrice}',
                                    style: TextStyle(
                                        color: Colors.green, fontSize: 11.0),
                                  ),
                                ),
                              ])),
                      SizedBox(
                        height: Constant.sizedBoxSize5,
                      ),
                      Flexible(
                          flex: 1,
                          child: Text(
                            _listOfProduct[index].description,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Constant.highlightedColor,
                            ),
                          ))
                    ],
                  ),
                ),
              ),
            ),
            //stack seco
            Positioned(
              top: 20.0,
              right: 20.0,
              child: CircleButton(
                  iconData: pInCartExists
                      ? FlutterIcons.md_checkmark_ion
                      : FlutterIcons.md_add_ion,
                  onTap: () {
                    _productBloc.add(AddToCart(productid: _listOfProduct[index].id));
                  },
                  iconSize: 20.0,
                  backgroundColor:
                      pInCartExists ? Colors.green : Colors.black38),
            ),
          ],
        );
      }),
    );
  }

  bool inCart(String id) {
    print(_cart.toString());
    if (_cart != null) {
      if (_cart.productIds.contains(id))
        return true;
      else
        return false;
    }else {
      return false;
    }
  }

  //method
  navigateToProductDetailPage(index, product) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ProductDetail(
                  tagIndex: index,
                  product: product,
                )));
  }
}
