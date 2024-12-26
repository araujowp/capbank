// ignore_for_file: avoid_print

import 'package:capbank/service/user/user_dto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class UserService {
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref("user");
  final FirebaseAuth _auth = FirebaseAuth.instance;

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

  Future<String> login(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        return userCredential.user!.uid;
      } else {
        throw Exception("Erro inesperado: usuário não encontrado.");
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      if (e.code == 'user-not-found') {
        errorMessage = "Usuário não encontrado.";
      } else if (e.code == 'wrong-password') {
        errorMessage = "Senha incorreta.";
      } else {
        errorMessage = "Erro ao autenticar: ${e.message}";
      }
      throw Exception(errorMessage);
    } catch (e) {
      throw Exception("Erro inesperado: ${e.toString()}");
    }
  }

  Future<UserDTO> getUser(String uuid) async {
    try {
      print('Buscando usuário com UUID filtro: $uuid');
      Query query = _dbRef.orderByChild("uuid").equalTo(uuid);
      DatabaseEvent event = await query.once();

      print('Resultado da consulta: ${event.snapshot.value}');

      if (event.snapshot.exists) {
        final Map<String, dynamic> data =
            Map<String, dynamic>.from(event.snapshot.value as Map);

        final userData = data.values.firstWhere(
          (user) => user['uuid'] == uuid,
          orElse: () => null,
        );
        UserDTO userDTO = UserDTO.fromMap(Map<String, dynamic>.from(userData));

        print("======  ===== aqui temos2 : ${userDTO.photo}");
        return userDTO;
      } else {
        throw Exception("Usuário com UUID $uuid não encontrado.");
      }
    } catch (e) {
      throw Exception("erro ao buscar usuario $e");
    }
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
