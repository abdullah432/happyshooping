class UserRepository {
  Future<String> authenticate(String username, String password) async {
    await Future.delayed(Duration(seconds: 4));
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
