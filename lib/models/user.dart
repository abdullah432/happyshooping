// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

class User {
  String id;
  String name;
  String email;
  int phonenumber;
  String profileUrl;
  int pending;
  int approved;
  int totalEarning;
  // GeoPoint _geoPoint;
  String address;

  //singleton logic
  static final User user = User._internal();
  User._internal();
  factory User() {
    return user;
  }

  User.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    name = json["name"];
    email = json["email"];
    pending = json["pending"];
    approved = json["approved"];
    totalEarning = json["total_earning"];
  }

  // User.nonSignleton(
  //     {@required this.id,
  //     @required this.name,
  //     @required this.email,
  //     @required this.pending,
  //     @required this.approved,
  //     @required this.totalEarning});

  // factory User.fromJson(Map<String, dynamic> json) {
  //   return User.nonSignleton(
  //     id: json["_id"],
  //     name: json["name"],
  //     email: json["email"],
  //     pending: json["pending"],
  //     approved: json["approved"],
  //     totalEarning: json["total_earning"],
  //   );
  // }

  void clearUserData() {
    name = '';
    email = '';
    phonenumber = 0;
    profileUrl = '';
    id = '';
    pending = 0;
    approved = 0;
    totalEarning = 0;
  }
}
