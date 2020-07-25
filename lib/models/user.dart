// import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String _id;
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
      _id = json["_id"];
      name = json["name"];
      email = json["email"];
      pending = json["pending"];
      approved = json["approved"];
      totalEarning = json["total_earning"];
      profileUrl = json["profile_url"];
  }

  get id => _id;

  void clearUserData() {
    name = '';
    email = '';
    phonenumber = 0;
    profileUrl = '';
    _id = '';
    pending = 0;
    approved = 0;
    totalEarning = 0;
  }
}
