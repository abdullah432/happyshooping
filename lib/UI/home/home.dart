import 'package:flutter/material.dart';
import 'package:happyshooping/UI/home/custom_search_sliverheader.dart';
import 'package:happyshooping/UI/home/search_bar_widget.dart';
import 'package:happyshooping/Utils/Constant.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Color> colors = <Color>[
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.orange
  ];
  final List<String> stores = <String>[
    'Near You',
    'Grocery',
    'Clothes',
    'Electronics',
    'Beauty',
    'Travel',
    'Restaurants'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverAppBar(
          floating: true,
          title: Text('HappyShooping',
              style: TextStyle(color: Constant.primaryColor)),
          expandedHeight: 120,
          flexibleSpace: FlexibleSpaceBar(background: MyFlexibleSearchBar()),
          elevation: 0.0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return horizontalStoresList(index);
            },
            childCount: stores.length,
          ),
        ),
      ],
    ));
  }

  //horizontal list containing stores
  horizontalStoresList(index) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: Constant.lrSidePadding),
            child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  stores[index],
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
                )),
          ),
          Container(
            height: 85,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 15,
                itemBuilder: (context, index) => Container(
                      width: 130.0,
                      child: Card(
                        color: (index % 2 == 0)
                            ? Constant.customColor1
                            : Constant.customColor2,
                        margin: const EdgeInsets.all(10),
                        child: Center(
                          child: const Icon(Icons.ac_unit),
                        ),
                      ),
                    )),
          )
        ],
      ),
    );
  }
}
