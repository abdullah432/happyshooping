import 'package:dio/dio.dart';
import 'package:happyshooping/Utils/Constant.dart';
import 'package:happyshooping/models/cart.dart';
import 'package:happyshooping/models/product.dart';
import 'package:meta/meta.dart';

class ProductRepository {
  var _url = '${Constant.basicURL}/product';

  Future<List<Product>> loadProductsWithStoreId({@required String storeID}) async {
    var url = _url + '/getProductsByStoreID/$storeID';
    Response response = await Dio().post(
      url,
      // queryParameters: {"id": id},
      options: Options(headers: {"Content-Type": "application/json"}),
    );

    if (response.statusCode == 200) {
      return (response.data["data"] as List)
          .map((s) => Product.fromJson(s))
          .toList();
    } else {
      final error = response.data["status"];
      print("error: " + error);
      throw (error);
    }
  }

  Future<List<Product>> loadListOfProductInUserCart() async{
    var url = _url + '/loadListOfProductsFromArrayOfProductID';
    //cart value should be updated before calling loadListOfProductInUserCart()
    //Cart is singleton so we can access it from here
    Cart cart = Cart();
    Response response = await Dio().post(
      url,
      data: {"productIds": cart.productIds},
      options: Options(headers: {"Content-Type": "application/json"}),
    );

    if (response.statusCode == 200) {
      return (response.data["data"] as List)
          .map((s) => Product.fromJson(s))
          .toList();
    } else {
      final error = response.data["status"];
      print("error: " + error);
      throw (error);
    }
  }
}
