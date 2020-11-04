import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:happyshooping/Utils/Constant.dart';
import 'package:happyshooping/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

class UserRepository {
  // Create storage
  final _storage = FlutterSecureStorage();
  User user = User();
  //for web
  // var _url = 'http://localhost:9000/api/user/';
  //for mobile
  var _url = '${Constant.basicURL}/user/';

  Future<String> authenticate(
      {@required String email, @required String password}) async {
    //login login here
    var loginUrl = '${_url}login';
    try {
      var response = await http
          .post(loginUrl,
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: jsonEncode(
                  <String, String>{'email': email, 'password': password}))
          .timeout(Duration(seconds: 8));
      if (response.statusCode == 200) {
        final jsonDecode = json.decode(response.body);
        final token = jsonDecode["token"];
        final userid = jsonDecode["userid"];
        saveTokenAndID(token, userid);
        return "success";
      } else if (response.statusCode == 403) {
        final jsonDecode = json.decode(response.body);
        final error = jsonDecode["error"];
        print("error: " + error);
        return error;
      } else {
        print("Failed");
        return 'Login Failed';
      }
    } on SocketException catch (error) {
      print("Exception: " + error.toString());
      print("Exception: " + error.message);
      if (error.message.isNotEmpty)
        return error.message;
      else
        return "Login Failed";
    } catch (error) {
      print("Exception: " + error.toString());
      return 'Login Failed';
    }
  }

  Future<String> signup(
      {@required String name,
      @required email,
      @required String password}) async {
    //singup login here
    var signupUrl = '${_url}register';
    print("signupurl: " + signupUrl);
    try {
      var response = await http
          .post(signupUrl,
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: jsonEncode(<String, String>{
                'name': name,
                'email': email,
                'password': password
              }))
          .timeout(Duration(seconds: 8));
      if (response.statusCode == 200) {
        final jsonDecode = json.decode(response.body);
        final token = jsonDecode["token"];
        final userid = jsonDecode["userid"];
        saveTokenAndID(token, userid);
        return "success";
      } else if (response.statusCode == 403) {
        final jsonDecode = json.decode(response.body);
        final error = jsonDecode["error"];
        print("error: " + error);
        return error;
      } else {
        print("Failed");
        return 'Registeration Failed';
      }
    } on SocketException catch (error) {
      print("Exception: " + error.toString());
      print("Exception: " + error.message);
      if (error.message.isNotEmpty)
        return error.message;
      else
        return "Login Failed";
    } catch (error) {
      print("Exception: " + error.toString());
      return 'Registeration Failed';
    }
  }

  Future<void> deleteToken() async {
    //delete token keystore/keychain
    // Delete value
    await _storage.delete(key: 'token');
    return;
  }

  Future<void> saveTokenAndID(String token, String userid) async {
    //When user signin or signup then we will also update user.id. So we can retrieve cart etc ...
    user.id = userid;
    // write to keystore/keychain
    await _storage.write(key: "token", value: token);
    await _storage.write(key: "userid", value: userid);
    return;
  }

  Future<bool> hasLoggedIn() async {
    /// read from keystore/keychain
    // Read value
    try {
      String token = await _storage.read(key: "token");
      String userid = await _storage.read(key: "userid");
      if (token != null && userid != null) {
        user.id = userid;
        return true;
      } else
        return false;
    } catch (error) {
      print("hasToken exception: " + error.toString());
      print("Key is not store yet");
      return false;
    }
  }

  Future<String> getUserToken() async {
    /// read from keystore/keychain
    // Read value
    try {
      String token = await _storage.read(key: "token");
      return token;
    } catch (error) {
      print("hasToken exception: " + error.toString());
      print("Key is not store yet");
      return error.message;
    }
  }

  Future<void> loadUserData() async {
    Response response = await Dio().post(_url + 'getUserDataByID/${user.id}');
    fetchFromJSON2(response);
    return;
    //non singleton way
    // Response response = await Dio().post(_url+'/${user.id}');
    // return User.fromJson(response.data["data"]);
  }

  Future<void> updateName(String name) async {
    try {
      Response response = await Dio()
          .patch(_url + 'updateName/${user.id}',
          data: {"name": name},
          );
      fetchFromJSON2(response);
      // var response = await http
      //     .patch(_url + 'updateName/${user.id}',
      //         headers: <String, String>{
      //           'Content-Type': 'application/json; charset=UTF-8',
      //           "auth-token": token
      //         },
      //         body: jsonEncode(<String, String>{'name': name}))
      //     .timeout(Duration(seconds: 8));
      // final jsonDecode = json.decode(response.body);
      // fetchFromJSON(jsonDecode["data"][0]);
      return;
    } catch (error) {
      print(error);
      throw (error);
    }
  }

  fetchFromJSON(Map<String, dynamic> json) {
    // final json = response.data["data"][0];
    print('json: ' + json["name"]);
    user.name = json["name"];
    user.email = json["email"];
    user.pending = json["pending"];
    user.approved = json["approved"];
    user.totalEarning = json["total_earning"];
  }

  fetchFromJSON2(Response response) {
    final json = response.data["data"][0];
    print('json: ' + json["name"]);
    user.name = json["name"];
    user.email = json["email"];
    user.pending = json["pending"];
    user.approved = json["approved"];
    user.totalEarning = json["total_earning"];

    print('approved: ${user.approved}');
  }
}
