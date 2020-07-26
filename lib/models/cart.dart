// import 'package:cloud_firestore/cloud_firestore.dart';

class Cart {
  String id;
  String userId;
  List<String> productIds;

  //singleton logic
  static final Cart cart = Cart._internal();
  Cart._internal();
  factory Cart() {
    return cart;
  }

//initializing with second constructor, it will not remain singleton

//  Cart.fromJson(Map<String, dynamic> json) {
//       _id = json["_id"];
//       user_id = json["user_id"];
//       product_ids = json["product_ids"].cast<String>();

//       // print('Id: '+_id);
//       // print('_user_id: '+_user_id);
//       // print('_product_ids: '+_product_ids.toString());
//   }

  @override
  String toString() {
    return 'id: $id\nuserid: $userId\nproductids: $productIds';
  }

}
