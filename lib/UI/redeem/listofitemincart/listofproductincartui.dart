import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:happyshooping/UI/common/circle_button.dart';
import 'package:happyshooping/UI/redeem/uploadreceipt/uploadreceiptpage.dart';
import 'package:happyshooping/Utils/Constant.dart';
import 'package:happyshooping/bloc/cartproductlistredeem/cartproductlistbloc.dart';
import 'package:happyshooping/models/product.dart';

class ListOfProductsInCartUI extends StatefulWidget {
  final imagePath;
  final storeId;
  ListOfProductsInCartUI({@required this.imagePath, @required this.storeId});
  @override
  State<StatefulWidget> createState() {
    return ListOfProductsInCartUIState(imagePath, storeId);
  }
}

class ListOfProductsInCartUIState extends State<ListOfProductsInCartUI> {
  String imagePath;
  String storeId;
  ListOfProductsInCartUIState(this.imagePath, this.storeId);
  CartProductsListBloc _cartProductsListBloc;
  @override
  Widget build(BuildContext context) {
    _cartProductsListBloc = BlocProvider.of<CartProductsListBloc>(context);
    return BlocBuilder<CartProductsListBloc, CartProductsListState>(
      builder: (context, state) {
        if (state is InitialCartProductsListState ||
            state is FetchingInProgress)
          return Center(child: SpinKitPulse(size: 51.0, color: Colors.green));
        if (state is FetchCartProductsListSuccess) {
          return showCartProductsList(state.productsList, state.checked);
        }
        if (state is CheckedBoxClickedHappened) {
          return showCartProductsList(state.productsList, state.checked,
              collectCashback: state.collectCashback, products: state.products);
        }
        if (state is FetchCartProductsListFail)
          return Center(
              child: Text(state.error,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.red)));
      },
    );
  }

  showCartProductsList(List<Product> productsList, List<bool> checked,
      {int collectCashback, List<String> products}) {
    return Stack(children: [
      //list of products in cart
      ListView.builder(
          itemCount: productsList.length,
          itemBuilder: (context, index) {
            return Padding(
                padding:
                    const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 8.0),
                child: Column(children: [
                  Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(children: [
                          SizedBox(width: 5),
                          //check box
                          CircleButton(
                            iconData: FlutterIcons.md_checkmark_ion,
                            onTap: () {
                              // checkBoxClick(index);
                              _cartProductsListBloc
                                  .add(CheckBoxClicked(index: index));
                            },
                            iconSize: 25.0,
                            backgroundColor:
                                checked[index] ? Colors.green : Colors.black38,
                          ),
                          SizedBox(width: 10),
                          //product image
                          CachedNetworkImage(
                            width: 60.0,
                            imageUrl: productsList[index].imageUrl,
                            placeholder: (context, url) =>
                                const SpinKitThreeBounce(
                              color: Colors.black,
                              size: 10.0,
                            ),
                            errorWidget: (context, url, error) => Icon(
                              Icons.error,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(width: 10),
                          //Column with three text children
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    'Rs ${productsList[index].cashback} cashback',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green)),
                                Container(
                                  constraints: BoxConstraints(maxWidth: 180),
                                  child: Text(
                                      '${productsList[index].description}',
                                      style: TextStyle(
                                          color: Constant.highlightedColor,
                                          fontSize: 12),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis),
                                ),
                                Text(
                                  'Price ${productsList[index].totalPrice}',
                                  style: TextStyle(),
                                ),
                              ]),
                        ]),
                      )),
                ]),
            );
          }),
      //bottom button
      Visibility(
          visible:
              (collectCashback == null || collectCashback == 0) ? false : true,
          child: Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                  // color: Colors.green,
                  decoration: new BoxDecoration(
                      color: Colors.green,
                      borderRadius: new BorderRadius.only(
                        topLeft: const Radius.circular(8.0),
                        topRight: const Radius.circular(8.0),
                      )),
                  child: GestureDetector(
                    onTap: () {
                      navigateToUploadReceiptPage(products, collectCashback);
                    },
                    child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Center(
                            child: RichText(
                                text: TextSpan(
                                    text: 'Collect Cashback ',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 18),
                                    children: <TextSpan>[
                              TextSpan(
                                text: 'Rs. $collectCashback',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )
                            ])))),
                  ))))
    ]);
  }

  navigateToUploadReceiptPage(List<String> products, int collectCashback) {
    // print('imagepath: ' + imagePath);
    // print('storeid: ' + storeId);
    // print('products: ' + products.toString());
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => UploadReceiptPage(
                  imagePath: imagePath,
                  storeId: storeId,
                  products: products,
                  collectCashback: collectCashback,
                )));
  }
}
