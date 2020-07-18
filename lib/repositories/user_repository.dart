import 'dart:convert';
import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

class UserRepository {
  // Create storage
  final _storage = FlutterSecureStorage();
  var _url = 'http://localhost:9000/api/user/';
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
        saveToken(token);
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

  Future<void> saveToken(String token) async {
    /// write to keystore/keychain
    // Write value
    await _storage.write(key: "token", value: token);

    print("token: " + token);
    return;
  }

  Future<bool> hasToken() async {
    /// read from keystore/keychain
    // Read value
    try {
    String value = await _storage.read(key: "token");
    print('hastoken: '+value);
    if (value == null)
      return false;
    else
      return true;
    }catch(error) {
      print("hasToken exception: "+error.toString());
      print("Key is not store yet");
      return false;
    }
  }
}
