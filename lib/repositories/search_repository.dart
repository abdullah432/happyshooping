import 'package:dio/dio.dart';
import 'package:happyshooping/Utils/Constant.dart';
import 'package:happyshooping/models/product.dart';
import 'package:happyshooping/models/store.dart';
import 'package:meta/meta.dart';

class SearchRepository {
  var _url = '${Constant.basicURL}/api/search';
  Future<List<Object>> searchMyText({@required String searchedText}) async {
    try {
      Response response = await Dio().post(
        _url,
        data: {"searchText": searchedText},
        options: Options(headers: {"Content-Type": "application/json"}),
      );

      if (response.statusCode == 200) {
        if (response.data["type"] == 'STORE') {
          //before displaying search result this value will be checked to detemined
          //to show store or product list
          Constant.isStore = true;
          return (response.data["data"] as List)
              .map((s) => Store.fromJson(s))
              .toList();
        } else {
          Constant.isStore = false;
          return (response.data["data"] as List)
              .map((s) => Product.fromJson(s))
              .toList();
        }
      } else {
        print('Server return error in searchMyText');
        throw response.data["error"];
      }
    } catch (error) {
      print('Exception in searchMyText');
      throw error;
    }
  }
}
