import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:happyshooping/UI/common/remove_scrollglow.dart';
import 'package:happyshooping/UI/display_products.dart';
import 'package:happyshooping/UI/home/search_bar_widget.dart';
import 'package:happyshooping/Utils/Constant.dart';
import 'package:happyshooping/models/store.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Store> nearYou;
  List<Store> grocery;
  List<Store> clothes;
  List<Store> electronics;

  List<List<Store>> filteredCategories = new List();

  final List<Store> _listOfStores = [
    Store(
        id: '1',
        name: 'Metro',
        iconUrl:
            'https://logos-download.com/wp-content/uploads/2016/05/Metro_logo_yellow-white.png',
        address: 'GeoPoint',
        categories: ['Near You', 'Grocery', 'Electronics']),
    Store(
        id: '2',
        name: 'J.',
        iconUrl:
            'https://propakistani.pk/how-to/wp-content/uploads/2020/03/Logo-001.png',
        address: 'GeoPoint',
        categories: ['Clothes', 'Beauty']),
    Store(
        id: '3',
        name: 'Carrefour',
        iconUrl:
            'https://1000logos.net/wp-content/uploads/2019/05/Lowe%E2%80%99s-Logo.png',
        address: 'GeoPoint',
        categories: ['Near You', 'Grocery', 'Electronics']),
    Store(
        id: '4',
        name: 'Jalal Sons',
        iconUrl: 'https://ipc-me.com/uploads/bran-partners-noborder1.png',
        address: 'GeoPoint',
        categories: ['Grocery', 'Clothes', 'Electronics']),
  ];

  final List<String> _listOfCategories = <String>[
    'Near You',
    'Grocery',
    'Clothes',
    'Electronics',
    // 'Beauty',
    // 'Travel',
    // 'Restaurants'
  ];

  void _filterStores() {
    nearYou = _listOfStores
        .where((store) => store.categories.contains('Near You'))
        .toList();
    grocery = _listOfStores
        .where((store) => store.categories.contains('Grocery'))
        .toList();
    clothes = _listOfStores
        .where((store) => store.categories.contains('Clothes'))
        .toList();
    electronics = _listOfStores
        .where((store) => store.categories.contains('Electronics'))
        .toList();
    filteredCategories.add(nearYou);
    filteredCategories.add(grocery);
    filteredCategories.add(clothes);
    filteredCategories.add(electronics);
  }

  @override
  void initState() {
    _filterStores();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          floating: true,
          title: Text('HappyShooping',
              style: TextStyle(color: Constant.primaryColor)),
          expandedHeight: 120,
          flexibleSpace: FlexibleSpaceBar(background: MyFlexibleSearchBar()),
          elevation: 0.0,
          // backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          backgroundColor: Constant.customColor4,
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return horizontalStoresList(index);
            },
            childCount: _listOfCategories.length,
          ),
        ),
      ],
    );
  }

  //horizontal list containing stores
  horizontalStoresList(vLindex) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0, left: 10.0, bottom: 15.0),
      child: Column(
        children: [
          Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(
                  _listOfCategories[vLindex],
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
                ),
              )),
          Container(
            height: 95,
            child: ScrollConfiguration(
                behavior: RemoveScrollGlow(),
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: filteredCategories[vLindex].length,
                    itemBuilder: (context, hLindex) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 5,
                              child: GestureDetector(
                                onTap: () {
                                  navigateToDisplayProductPage(
                                      filteredCategories[vLindex][hLindex].id,
                                      filteredCategories[vLindex][hLindex]
                                          .name);
                                },
                                child: Container(
                                  width: 130.0,
                                  child: Card(
                                    color: (hLindex % 2 == 0)
                                        ? Constant.customColor1
                                        : Constant.customColor2,
                                    margin: const EdgeInsets.all(10),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Center(
                                        child: CachedNetworkImage(
                                          imageUrl: filteredCategories[vLindex]
                                                  [hLindex]
                                              .iconUrl,
                                          placeholder: (context, url) =>
                                              const SpinKitThreeBounce(color: Colors.white, size: 20.0,),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 12.0),
                                  child: Text(filteredCategories[vLindex]
                                          [hLindex]
                                      .name),
                                )),
                          ],
                        ))),
          ),
        ],
      ),
    );
  }

  navigateToDisplayProductPage(pId, storename) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return DisplayProducts(
        id: pId,
        storename: storename,
      );
    }));
  }
}
