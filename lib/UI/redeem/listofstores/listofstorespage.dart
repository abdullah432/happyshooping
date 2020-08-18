import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happyshooping/UI/redeem/listofstores/listofstoresui.dart';
import 'package:happyshooping/Utils/Constant.dart';
import 'package:happyshooping/bloc/storeslistredeem/storeslistbloc.dart';

class StoresListPage extends StatelessWidget {
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
          'Select Retailer',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body:BlocProvider<StoresListBloc>(
      create: (context) => StoresListBloc()..add(FetchStoresList()),
      child: StoresListUI()));
  }
}