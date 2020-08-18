import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happyshooping/UI/redeem/uploadreceipt/uploadreceiptui.dart';
import 'package:happyshooping/bloc/uploadreceipt/uploadreceiptbloc.dart';

class UploadReceiptPage extends StatelessWidget {
  final imagePath;
  final storeId;
  final products;
  final collectCashback;
  UploadReceiptPage({
    @required this.imagePath,
    @required this.storeId,
    @required this.products,
    @required this.collectCashback,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocProvider<UploadReceiptBloc>(
      create: (context) => UploadReceiptBloc(),
      child: UploadReceiptUI(
        imagePath: imagePath,
        storeId: storeId,
        products: products,
        collectCashback: collectCashback
      ),
    ));
  }
}
