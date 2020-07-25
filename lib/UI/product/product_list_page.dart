import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happyshooping/UI/product/product_list.dart';
import 'package:happyshooping/bloc/product/product_bloc.dart';
import 'package:happyshooping/Utils/Constant.dart';

class ProductListPage extends StatelessWidget {
  final _storeID;
  final _storeName;
  ProductListPage({@required storeID, @required storeName}): _storeID = storeID, _storeName = storeName;
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
          _storeName,
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          )
        ],
      ),
      body: BlocProvider<ProductBloc>(
      create: (context) => ProductBloc()..add(FetchProduct(storeID: _storeID)),
      child: ProductList(),
    ));
  }
}
