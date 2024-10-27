import 'package:capbank/service/user_dto.dart';

class UserService {
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
}
