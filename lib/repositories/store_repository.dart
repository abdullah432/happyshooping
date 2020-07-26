import 'dart:convert';

import 'package:happyshooping/models/store.dart';
import 'package:dio/dio.dart';

class StoreRepository {
  var _url = 'http://192.168.10.3:9000/api/store/getAllStores';

  Future<List<Store>> loadStores() async {
    //DIO returns decoded MAP. not required to decode
    Response response = await Dio().get(_url);

    if (response.statusCode == 200) {
      return (response.data["data"] as List)
          .map((s) => Store.fromJson(s))
          .toList();
    } else {
      print(response.data["status"]);
    }
  }

  List<List<Store>> filteredCategories(List<Store> listOfStores) {
    //Each category is inside index of this list like at index one list of 'Near You' stores

    List<List<Store>> filteredCategories = List();
    List<Store> filteredList;
    filteredList = listOfStores
        .where((store) => store.categories.contains('Near You'))
        .toList();

    filteredCategories.add(filteredList);

    filteredList = listOfStores
        .where((store) => store.categories.contains('Grocery'))
        .toList();
    filteredCategories.add(filteredList);

    filteredList = listOfStores
        .where((store) => store.categories.contains('Clothes'))
        .toList();
    filteredCategories.add(filteredList);

    filteredList = listOfStores
        .where((store) => store.categories.contains('Electronics'))
        .toList();
    filteredCategories.add(filteredList);

    return filteredCategories;
  }
}
