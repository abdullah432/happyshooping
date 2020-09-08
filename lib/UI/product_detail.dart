import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:happyshooping/Utils/Constant.dart';
import 'package:happyshooping/models/cart.dart';
import 'package:happyshooping/models/product.dart';
import 'package:happyshooping/repositories/cart_repository.dart';

import 'common/circle_button.dart';

class ProductDetail extends StatefulWidget {
  final tagIndex;
  final _product;
  ProductDetail({@required this.tagIndex, @required product})
      : _product = product;
  @override
  State<StatefulWidget> createState() {
    return _ProductDetailState(tagIndex, _product);
  }
}

class _ProductDetailState extends State<ProductDetail> {
  int tagIndex;
  Product _product;
  //cart
  bool pInCartExists;
  Cart _cart = Cart();
  CartRepository _cartRepository = CartRepository();

  _ProductDetailState(this.tagIndex, this._product);
  @override
  Widget build(BuildContext context) {
    pInCartExists = inCart(_product.id);
    return Hero(
        tag: 'tag$tagIndex',
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0.0,
              iconTheme: IconThemeData(
                color: Colors.black, //change your color here
              ),
              title: Text(
                _product.description,
                style: TextStyle(color: Colors.black),
              ),
            ),
            body: Stack(
              children: [
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: Constant.lrSidePadding,
                        right: Constant.lrSidePadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: CachedNetworkImage(
                            height: 200.0,
                            imageUrl: _product.imageUrl,
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
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Rs ${_product.cashback} cashback',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              RichText(
                                text: TextSpan(
                                  text: 'Price  ',
                                  style: TextStyle(
                                      color: Colors.green, fontSize: 19.0),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: 'Rs.${_product.totalPrice}',
                                        style: TextStyle(
                                            color: Colors.black45,
                                            fontSize: 15)),
                                  ],
                                ),
                              ),
                              // Text(
                              //   'Price  Rs.${_product.totalPrice}',
                              //   style: TextStyle(fontSize: 16, color: Colors.green),
                              // ),
                            ]),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          'About the product',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          _product.description,
                          style: TextStyle(
                              fontSize: 15, color: Constant.highlightedColor),
                        ),
                      ],
                    ),
                  ),
                ),
                //
                Positioned(
                  top: 20.0,
                  right: 20.0,
                  child: CircleButton(
                      iconData: pInCartExists
                          ? FlutterIcons.md_checkmark_ion
                          : FlutterIcons.md_add_ion,
                      onTap: () async {
                        // _productBloc.add(AddToCart(productid: _listOfProduct[index].id));
                        String result = await _cartRepository
                            .addorRemoveCartListner(productID: _product.id);
                        print(result);
                        setState(() {});
                      },
                      iconSize: 25.0,
                      backgroundColor:
                          pInCartExists ? Colors.green : Colors.black38),
                ),
              ],
            )));
  }

  bool inCart(String id) {
    print(_cart.toString());
    if (_cart != null) {
      if (_cart.productIds.contains(id))
        return true;
      else
        return false;
    } else {
      return false;
    }
  }
}
