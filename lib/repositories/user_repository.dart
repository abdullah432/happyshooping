import 'package:meta/meta.dart';

class UserRepository {
  Future<String> authenticate(String username, String password) async {
    //login login here
    await Future.delayed(Duration(seconds: 4));
    return 'token';
  }

  Future<String> signup({@required String name, @required email, @required String password}) async{
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
    await Future.delayed(Duration(seconds: 3));
    return;
  }

  Future<bool> hasToken() async {
    /// read from keystore/keychain
    await Future.delayed(Duration(seconds: 3));
    return false;
  }
}
