// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';

class Authenticate {
  // Método para autenticar anonimamente
  Future<void> authenticateAnonymously() async {
    try {
      User? user = FirebaseAuth
          .instance.currentUser; // Verifica se o usuário já está autenticado
      if (user == null) {
        await FirebaseAuth.instance.signInAnonymously(); // Autenticação anônima
        print("Usuário autenticado anonimamente.");
      } else {
        print("Usuário já autenticado: \${user.uid}");
      }
    } catch (e) {
      print("Erro ao autenticar anonimamente: \$e");
      rethrow; // Propaga o erro se necessário
    }
  }
}
