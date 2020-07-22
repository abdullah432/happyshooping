import 'package:flutter/material.dart';
import 'package:happyshooping/Utils/Constant.dart';

class DisplayProducts extends StatefulWidget {
  final _id;
  DisplayProducts({@required id}) : _id = id;
  @override
  State<StatefulWidget> createState() {
    return _DisplayProductsState(_id);
  }
}

class _DisplayProductsState extends State<DisplayProducts> {
  String _id;
  _DisplayProductsState(this._id);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constant.customColor4,
      body:  Center(
      child: Text('Display Products ' + _id),
    ));
  }
}
