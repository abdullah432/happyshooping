import 'package:dio/dio.dart';
import 'package:happyshooping/Utils/Constant.dart';
import 'package:happyshooping/models/cart.dart';
import 'package:happyshooping/models/user.dart';
import 'package:meta/meta.dart';

class CartRepository {
  var _url = '${Constant.basicURL}/api/cart';

  Cart cart = Cart();
  User _user = User();

  //load user is called in product bloc before return ProductFetchSuccess State
  loadUserCart() async {
    var url = _url + '/getcartbyid/${_user.id}';
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

  //this method is called in Product bloc
  Future<String> addorRemoveCartListner({@required String productID}) async {
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
