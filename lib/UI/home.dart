import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:happyshooping/UI/account/account.dart';
import 'package:happyshooping/UI/submit_receipt/submit_receipt.dart';
import 'package:happyshooping/Utils/Constant.dart';
import 'package:flutter_icons/flutter_icons.dart';

import 'home/home_page.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constant.customColor4,
      body: IndexedStack(
        index: _currentIndex,
        children: [
          HomePage(),
          SubmitReceipt(),
          AccountPage(),
        ],
      ),
      bottomNavigationBar: 
    ClipRRect(
      borderRadius: BorderRadius.only(
          topRight: Radius.circular(12), topLeft: Radius.circular(12)),
      child: BottomNavigationBar(
        elevation: 20.0,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: Colors.white,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: new Icon(FlutterIcons.home_oct, size: 30,),title: Text('Home')),
          BottomNavigationBarItem(
              icon: new Icon(FlutterIcons.receipt_mdi, size: 30,), title: Text('Submit Receipt')),
          BottomNavigationBarItem(
              icon: new Icon(FlutterIcons.md_person_ion, size: 30,), title: Text('Account')),
        ],
      ),
    ));
  }
}
