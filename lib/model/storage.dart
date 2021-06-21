import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  String _username = "";
  String _token = "";
  SharedPreferences _prefs;
  static Storage _storage;

  static Future<Storage> getInstance() async {
    if (_storage == null) {
      _storage = new Storage();
      _storage?._prefs = await SharedPreferences.getInstance();
      
    }
    return _storage;
  }

  String getToken() {
    if (_token != null && _token.isNotEmpty) return _token;
    return _prefs?.getString("token");
  }

  String getUsername() {
    if (_username != null && _token.isNotEmpty) return _username;
    return _prefs?.getString("username");
  }

  Future<void> setToken(String token) async {
    // check input
    _token = token;
    _prefs?.setString("token", token);
  }

  Future<void> setUsername(String username) async {
    // check input
    await _prefs?.setString("username", username);
    _username = username;
  }

  Future<void> removeTokenUser() async {
    await _prefs?.remove("username");
    await _prefs?.remove("token");
    _username = "";
    _token = "";
  }
}
