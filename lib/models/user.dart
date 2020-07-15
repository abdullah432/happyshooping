// import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  var _id;
  String _name;
  String _email;
  int _phonenumber;
  String _profileUrl;
  int _pending;
  int _approved;
  int _totalEarning;
  // GeoPoint _geoPoint;
  String _address;

  //singleton logic
  static final User user = User._internal();
  User._internal();
  factory User() {
    return user;
  }

 User.fromJson(Map<String, dynamic> json) {
      _id = json["_id"];
      _name = json["name"];
      _email = json["email"];
      _pending = json["pending"];
      _approved = json["approved"];
      _totalEarning = json["total_earning"];
      _profileUrl = json["profile_url"];
  }


  get getName {
    return _name;
  }

  get getEmail {
    return _email;
  }

  get getPhoneNumber {
    return _phonenumber;
  }

  get getImageUrl {
    return _profileUrl;
  }

  get getId {
    return _id;
  }

  get getAddress {
    return _address;
  }

  get getPendingAmount {
    return _pending;
  }

  get getApprovedAmount {
    return _approved;
  }

  get getTotalEarning {
    return _totalEarning;
  }

  // get getGeopoint {
  //   return _geoPoint;
  // }

  void setname(String value) {
    this._name = value;
  }

  void setEmail(String value) {
    this._email = value;
  }

  void setPhoneNum(int value) {
    this._phonenumber = value;
  }

  void setImageUrl(String value) {
    this._profileUrl = value;
  }

  void setUID(var value) {
    this._id = value;
  }

  void setAddress(String value) {
    _address = value;
  }

  void setPendingAmount(int value) {
    _pending = value;
  }

  void setApprovedAmount(int value) {
    _approved = value;
  }

  void setTotalAmount(int value) {
    _totalEarning = value;
  }

  // void setGeoPoint(GeoPoint value) {
  //   _geoPoint = value;
  // }


  void clearUserData() {
    _name = '';
    _email = '';
    _phonenumber = 0;
    _profileUrl = '';
    _id = '';
    _pending = 0;
    _approved = 0;
    _totalEarning = 0;
  }
}
