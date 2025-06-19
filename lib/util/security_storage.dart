import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static const _secureStorage = FlutterSecureStorage();

  static Future<void> saveLogin(String username, String password) async {
    Map<String, String?> logins = await getLogins();

    List<MapEntry<String, String?>> existingLogins = logins.entries
        .where((entry) => entry.key.isNotEmpty && entry.key != username)
        .toList();

    await _secureStorage.write(key: 'username1', value: username);
    await _secureStorage.write(key: 'password1', value: password);

    int index = 2;
    for (var entry in existingLogins) {
      if (entry.key.isNotEmpty) {
        await _secureStorage.write(key: 'username$index', value: entry.key);
        await _secureStorage.write(key: 'password$index', value: entry.value);
        index++;
      }
    }
  }

  static Future<Map<String, String?>> getLogins() async {
    Map<String, String?> loginData = {};

    Future<void> addIfNotNull(String? username, String? password) async {
      if (username != null) {
        loginData[username] = password;
      }
    }

    await addIfNotNull(
      await _secureStorage.read(key: 'username1'),
      await _secureStorage.read(key: 'password1'),
    );
    await addIfNotNull(
      await _secureStorage.read(key: 'username2'),
      await _secureStorage.read(key: 'password2'),
    );
    await addIfNotNull(
      await _secureStorage.read(key: 'username3'),
      await _secureStorage.read(key: 'password3'),
    );

    return loginData;
  }

  static Future<void> clearLogins() async {
    int index = 1;

    while (true) {
      String? username = await _secureStorage.read(key: 'username$index');

      if (username == null) {
        break; // Se não encontrar mais usernames, para o loop
      }

      await _secureStorage.delete(key: 'username$index');
      await _secureStorage.delete(key: 'password$index');

      index++;
    }
  }
}
