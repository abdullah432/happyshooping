import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:happyshooping/UI/common/remove_scrollglow.dart';
import 'package:happyshooping/UI/product/product_list.dart';
import 'package:happyshooping/UI/home/search_bar_widget.dart';
import 'package:happyshooping/UI/product/product_list_page.dart';
import 'package:happyshooping/Utils/Constant.dart';
import 'package:happyshooping/bloc/stores/store_bloc.dart';
import 'package:happyshooping/models/store.dart';

class HomeUI extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomeUI> {
  List<List<Store>> filteredCategoriesList = List();

  final List<String> _listOfCategories = <String>[
    'Near You',
    'Grocery',
    'Clothes',
    'Electronics',
    // 'Beauty',
    // 'Travel',
    // 'Restaurants'
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoreBloc, StoreState>(
      builder: (context, state) {
        if (state is InitialStoreState || state is FetchingInProgress)
          return Center(child: SpinKitPulse(size: 51.0, color: Colors.green));
        if (state is FetchStoresSuccess) {
          filteredCategoriesList = state.filteredCategoriesList;
          print('lenght: ' + filteredCategoriesList.length.toString());
          print('lenght: ' + filteredCategoriesList[0].length.toString());
          return showStoresList();
        }
        if (state is FetchStoresFail)
          return Center(
              child: Text(state.error,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.red)));
      },
    );
  }

  showStoresList() {
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
                    itemCount: filteredCategoriesList[vLindex].length,
                    itemBuilder: (context, hLindex) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 5,
                              child: GestureDetector(
                                onTap: () {
                                  navigateToDisplayProductPage(
                                      filteredCategoriesList[vLindex][hLindex]
                                          .id,
                                      filteredCategoriesList[vLindex][hLindex]
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
                                          imageUrl:
                                              filteredCategoriesList[vLindex]
                                                      [hLindex]
                                                  .iconUrl,
                                          placeholder: (context, url) =>
                                              const SpinKitThreeBounce(
                                            color: Colors.white,
                                            size: 20.0,
                                          ),
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
                                  child: Text(filteredCategoriesList[vLindex]
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

  navigateToDisplayProductPage(sId, storename) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ProductListPage(
        storeID: sId,
        storeName: storename,
      );
    }));
  }
}
