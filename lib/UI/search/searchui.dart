import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:happyshooping/UI/product/product_list_page.dart';
import 'package:happyshooping/Utils/Constant.dart';
import 'package:happyshooping/bloc/search/search_bloc.dart';
import 'package:happyshooping/models/product.dart';
import 'package:happyshooping/models/store.dart';
import '../product_detail.dart';
import 'searchbarwidget.dart';

class SearchUIPage extends StatefulWidget {
  SearchUIPage({Key key}) : super(key: key);

  @override
  _SearchUIPageState createState() => _SearchUIPageState();
}

class _SearchUIPageState extends State<SearchUIPage> {
  FocusNode _focusNode = FocusNode();
  //
  SearchBloc _searchBloc;

  @override
  Widget build(BuildContext context) {
    _searchBloc = BlocProvider.of<SearchBloc>(context);
    return BlocBuilder<SearchBloc, SearchState>(builder: (context, state) {
      if (state is SearchInitial) {
        return searchBar();
      }

      if (state is FetchSearchedDataSuccess) {
        print('Search result lenght: '+state.searchedResult.length.toString());
        return searchBarAndResult(state.searchedResult);
      }

      if (state is FetchSearchedDataFail) {
        return searchBarAndError(state.error);
      }
    });
  }

  searchBar() {
    return SearchUISearchBar(_focusNode, _searchBloc);
  }

  searchBarAndResult(searchResult) {
    return SingleChildScrollView(
      child: GestureDetector(
          onTap: () {
            setState(() {
              _focusNode.unfocus();
            });
          },
          child: Column(
            children: [
              //searchbar row
              searchBar(),
              //List of searched product
              searchResult.length == 0 ? noResultFoundWidget() :
              Constant.isStore
                  ? displayListOfStores(searchResult)
                  : displayListOfProducts(searchResult),
            ],
          )),
    );
  }

  searchBarAndError(String message) {
    return GestureDetector(
        onTap: () {
          setState(() {
            _focusNode.unfocus();
          });
        },
        child: Column(
          children: [
            //searchbar row
            searchBar(),
            //List of searched product
            Center(
              child: Container(
                height: 200,
                child: Center(child: Text(message)),
              ),
            )
          ],
        ));
  }

  displayListOfStores(List<Store> listOfStore) {
    return Padding(
      padding: const EdgeInsets.only(left: 4.0, right: 6.0),
      child: ListView.builder(
          itemCount: listOfStore.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                navigateToDisplayProductPage(
                    listOfStore[index].id, listOfStore[index].name);
              },
              child: Row(
                children: [
                  //ImageView
                  Container(
                    width: 130.0,
                    height: 80.0,
                    child: Card(
                      color: (index % 2 == 0)
                          ? Constant.customColor1
                          : Constant.customColor2,
                      margin: const EdgeInsets.all(10),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: CachedNetworkImage(
                            imageUrl: listOfStore[index].iconUrl,
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
                  //Detail
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          listOfStore[index].name,
                          style: TextStyle(color: Colors.black, fontSize: 17),
                        ),
                        SizedBox(
                          height: 6.0,
                        ),
                        RichText(
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          text: TextSpan(
                              text: 'Categories',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                              children: <TextSpan>[
                                TextSpan(
                                  text:
                                      ' ${listOfStore[index].categories.cast<String>()}',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal),
                                )
                              ]),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }

  noResultFoundWidget() {
    return Center(child: Padding(
      padding: const EdgeInsets.only(top: 30.0),
      child: Text('No Result Found'),
    ));
  }

  navigateToDisplayProductPage(sId, storename) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ProductListPage(
        storeID: sId,
        storeName: storename,
      );
    }));
  }

  displayListOfProducts(List<Product> listOfProduct) {
    return ListView.builder(
      itemCount: listOfProduct.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return GestureDetector(
            onTap: () {
              navigateToProductDetailPage(index, listOfProduct[index]);
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 12.0, right: 12.0),
              child: Card(
                  child: Row(children: [
                //imageview
                Container(
                  width: 60.0,
                  height: 80.0,
                  child: Center(
                    child: CachedNetworkImage(
                      imageUrl: listOfProduct[index].imageUrl,
                      placeholder: (context, url) => const SpinKitThreeBounce(
                        color: Colors.white,
                        size: 20.0,
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                ),
                SizedBox(
                  width: 5.0,
                ),
                //column in left of image
                Flexible(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //first row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Rs. ${listOfProduct[index].cashback} cashback',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 20.0),
                              child: Text(
                                  'Price ${listOfProduct[index].totalPrice}',
                                  style: TextStyle(color: Colors.greenAccent)),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        //title row
                        Text(listOfProduct[index].name,
                            maxLines: 2, overflow: TextOverflow.ellipsis),
                      ]),
                ),
              ])),
            ));
      },
    );
  }

  navigateToProductDetailPage(index, product) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ProductDetail(
                  tagIndex: index,
                  product: product,
                )));
  }
}
