import 'package:dio/dio.dart';
import 'package:happyshooping/Utils/Constant.dart';
import 'package:happyshooping/models/product.dart';
import 'package:meta/meta.dart';

class ProductRepository {
  var _url = '${Constant.basicURL}/api/product/getProductsByStoreID';

  Future<List<Product>> loadProductsWithId({@required String id}) async {
    var url = _url + '/$id';
    print('url: '+url);
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
}
