import 'package:dio/dio.dart';
import 'package:happyshooping/models/cart.dart';
import 'package:meta/meta.dart';

class CartRepository {
  var _url = 'http://192.168.10.4:9000/api/cart';

  Cart cart = Cart();

  loadUserCart({@required String id}) async {
    var url = _url + '/getcartbyid/$id';
    print('url: ' + url);
    Response response = await Dio().post(
      url,
      options: Options(headers: {"Content-Type": "application/json"}),
    );

    if (response.statusCode == 200) {
      final json = response.data["data"][0];
      //remove Cart.fromJson becaue Cart is singleton
      cart.id = json["_id"];
      cart.userId = json["user_id"];
      cart.productIds = json["product_ids"].cast<String>();
    } else {
      final error = response.data["status"];
      print("error: " + error);
      throw (error);
    }
  }

  Future<String> callCartListner({@required String productID}) async {
    try {
      var url = _url + '/cartlistner/${cart.userId}';
      Response response = await Dio().patch(
        url,
        data: {"product_id": productID},
        options: Options(headers: {"Content-Type": "application/json"}),
      );

      if (response.statusCode == 200) {
        final json = response.data["data"][0];
        //remove Cart.fromJson becaue Cart is singleton
        cart.id = json["_id"];
        cart.userId = json["user_id"];
        cart.productIds = json["product_ids"].cast<String>();

        return 'Success';
      } else {
        final error = response.data["status"];
        print("error: " + error);
        return '${error.message}';
      }
    } catch (error) {
      print('Exception in addProductToCart');
      return '${error.message}';
    }
  }
}
