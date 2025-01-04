import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static const _secureStorage = FlutterSecureStorage();

  static Future<void> saveLogin(String username, String password) async {
    await _secureStorage.write(key: 'username', value: username);
    await _secureStorage.write(key: 'password', value: password);
  }

  static Future<Map<String, String?>> getLogin() async {
    String? username = await _secureStorage.read(key: 'username');
    String? password = await _secureStorage.read(key: 'password');
    return {
      'username': username,
      'password': password,
    };
  }

  static Future<void> clearLogin() async {
    await _secureStorage.delete(key: 'username');
    await _secureStorage.delete(key: 'password');
  }
}
