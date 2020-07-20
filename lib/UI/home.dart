import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:happyshooping/UI/account/account.dart';
import 'package:happyshooping/UI/home/home_page.dart';
import 'package:happyshooping/Utils/Constant.dart';

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
          AccountPage(),
        ],
      ),
      bottomNavigationBar:ClipRRect(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(10), topLeft: Radius.circular(10)),
          child:  BottomNavigationBar(
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
           icon: new Icon(Icons.home),
           title: Text('Home')
         ),
         BottomNavigationBarItem(
           icon: new Icon(Icons.account_circle),
           title: Text('Account')
         ),
        ],
        ),
    ));
  }
}
