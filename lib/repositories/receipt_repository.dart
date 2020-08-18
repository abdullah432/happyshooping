import 'package:dio/dio.dart';
import 'package:happyshooping/Utils/Constant.dart';
import 'package:happyshooping/models/user.dart';
import 'package:meta/meta.dart';

class ReceiptRespository {
  User _user = User();
  var _url = '${Constant.basicURL}/api/receipt';
  Future<String> sendCashBackRequest({
    @required String downloadUrl,
    @required String storeId,
    @required int cashback,
    @required List<String> products,
  }) async {
    try {
      // userid: req.body.userid,
      //   storeid: req.body.storeid,
      //   receiptUrl: req.body.receiptUrl,
      //   cashback: req.body.cashback,
      //   products: req.body.products,
      var url = _url + '/addreceipt';
      Response response = await Dio().post(
        url,
        data: {"userid": _user.id, "storeid": storeId, "receiptUrl": downloadUrl, "cashback": cashback, "products": products},
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
