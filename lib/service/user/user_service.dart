import 'package:capbank/service/user/user_dto.dart';
import 'package:firebase_database/firebase_database.dart';

class UserService {
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref("user");

  final List<UserDTO> _users = [
    UserDTO(
        id: 1,
        name: 'Flávia Silva',
        photo: 'assets/images/capivara-mochila.jpg'),
    UserDTO(
        id: 2, name: 'Júlio César', photo: 'assets/images/capivara-brasil.jpg'),
    UserDTO(
        id: 3,
        name: 'Wagner Araújo',
        photo: 'assets/images/capivara-rosnando.jpg'),
  ];

  Future<List<UserDTO>> fetchUsers() async {
    await Future.delayed(const Duration(seconds: 1));
    return _users;
  }

  Future<bool> add(String name, int id, String uuid) async {
    try {
      final newUserRef = _dbRef.push();

      await newUserRef.set({"name": name, "id": id, "uuid": uuid});
      return true;
    } catch (e) {
      return false;
    }
  }
}
