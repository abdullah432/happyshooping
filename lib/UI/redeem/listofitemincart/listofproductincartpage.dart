import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happyshooping/Utils/Constant.dart';
import 'package:happyshooping/bloc/cartproductlistredeem/cartproductlistbloc.dart';

import 'listofproductincartui.dart';

class ListOfProductsInCartPage extends StatelessWidget {
  final imagePath;
  final storeId;
  const ListOfProductsInCartPage({@required this.imagePath, @required this.storeId});
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
            'Select item you buy',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: BlocProvider<CartProductsListBloc>(
            create: (context) =>
                CartProductsListBloc()..add(FetchCartProductsList()),
            child: ListOfProductsInCartUI()));
  }
}
