import 'package:flutter/material.dart';

class SubmitReceipt extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SubmitReceiptState();
  }

}

class _SubmitReceiptState extends State<SubmitReceipt> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text("Submit Receipt Page"),),);
  }

}