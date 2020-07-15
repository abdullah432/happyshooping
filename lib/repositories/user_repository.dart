import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

class UserRepository {
  Future<String> authenticate(
      {@required String email, @required String password}) async {
    //login login here
    var url = 'http://192.168.10.6:9000/api/user/login';
    try {
      var response = await http
          .post(url,
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: jsonEncode(
                  <String, String>{'email': email, 'password': password}))
          .timeout(Duration(seconds: 8));
      if (response.statusCode == 200) {
        final jsonDecode = json.decode(response.body);
        final token = jsonDecode["token"];
        saveToken(token);
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
    await Future.delayed(Duration(seconds: 3));
    return 'token';
  }

  Future<void> deleteToken() async {
    //delete token keystore/keychain
    await Future.delayed(Duration(seconds: 3));
    return;
  }

  Future<void> saveToken(String token) async {
    /// write to keystore/keychain
    // await Future.delayed(Duration(seconds: 3));
    print("token: " + token);
    return;
  }

  Future<bool> hasToken() async {
    /// read from keystore/keychain
    await Future.delayed(Duration(seconds: 1));
    return false;
  }
}
