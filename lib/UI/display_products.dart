import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:happyshooping/UI/product_detail.dart';
import 'package:happyshooping/Utils/Constant.dart';
import 'package:happyshooping/models/product.dart';

import 'common/circle_button.dart';

class DisplayProducts extends StatefulWidget {
  final _id;
  final _storename;
  DisplayProducts({@required id, @required storename})
      : _id = id,
        _storename = storename;
  @override
  State<StatefulWidget> createState() {
    return _DisplayProductsState(_id, _storename);
  }
}

class _DisplayProductsState extends State<DisplayProducts> {
  String _id;
  String _storename;
  _DisplayProductsState(this._id, this._storename);

  //dumy data
  bool inCart = true;

  List<Product> _listOfProduct = [
    Product.init(
        id: '1',
        name: '',
        description:
            'Soft Sillicone Airpods Pro Case For Apple Pro - Black/Green/Red/Brown',
        totalPrice: 180,
        cashback: 20,
        imageUrl: 'https://static-01.daraz.pk/p/81f1ae1bcc3719b0771c1048e10cc13c.jpg',
        categories: ['technology']),
    Product.init(
        id: '2',
        name: '',
        description: 'Spinach Per 500GM',
        totalPrice: 28,
        cashback: 8,
        imageUrl:
            'https://cdn.metro-online.pk/dashboard/prod-pic/LHE-01262/12620266-0-A.jpg',
        categories: ['grocery', 'vegetables']),
    Product.init(
        id: '3',
        name: '',
        description: 'Haleeb Milk 250ML',
        totalPrice: 35,
        cashback: 5,
        imageUrl:
            'https://cdn.metro-online.pk/dashboard/prod-pic/LHE-01262/12623022-0-M.jpg',
        categories: ['grocery', 'vegetables']),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constant.customColor4,
      appBar: AppBar(
        backgroundColor: Constant.customColor4,
        elevation: 0.0,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text(
          _storename,
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          )
        ],
      ),
      body: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 4 / 5,
        children: List.generate(_listOfProduct.length, (index) {
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                    iconData: inCart
                        ? FlutterIcons.md_checkmark_ion
                        : FlutterIcons.md_add_ion,
                    onTap: () {
                      print('add to cart');
                      if (inCart)
                        inCart = false;
                      else
                        inCart = true;

                      setState(() {});
                    },
                    iconSize: 20.0,
                    backgroundColor: inCart ? Colors.green : Colors.black38),
              ),
            ],
          );
        }),
      ),
    );
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
