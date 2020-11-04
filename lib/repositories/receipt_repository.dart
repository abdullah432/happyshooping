import 'package:dio/dio.dart';
import 'package:happyshooping/Utils/Constant.dart';
import 'package:happyshooping/models/user.dart';
import 'package:meta/meta.dart';

class ReceiptRespository {
  User _user = User();
  var _url = '${Constant.basicURL}/receipt';
  Future<String> sendCashBackRequest({
    @required String downloadUrl,
    @required String storeId,
    @required int cashback,
    @required List<String> products,
  }) async {
    try {
      var url = _url + '/addreceipt';
      Response response = await Dio().post(
        url,
        data: {"userid": _user.id, "username": _user.name, "storeid": storeId, "receiptUrl": downloadUrl, "cashback": cashback, "products": products, "no_of_products": products.length},
        options: Options(headers: {"Content-Type": "application/json"}),
      );

      if (response.statusCode == 200) {
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
