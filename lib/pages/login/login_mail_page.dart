// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginMailPage extends StatefulWidget {
  const LoginMailPage({super.key});

  @override
  State<LoginMailPage> createState() => _LoginMailPageState();
}

class _LoginMailPageState extends State<LoginMailPage> {
  final TextEditingController _mailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _login() async {
    // Verificar se o widget ainda está montado
    if (!mounted) return;

    // Captura o BuildContext antes de operações assíncronas
    final currentContext = context;

    if (_mailController.text.isEmpty || _passwordController.text.isEmpty) {
      // Verifique se o widget ainda está montado antes de chamar ScaffoldMessenger
      if (mounted) {
        ScaffoldMessenger.of(currentContext).showSnackBar(const SnackBar(
          content: Text("Preencha e-mail e senha"),
          backgroundColor: Colors.red,
        ));
      }
      return; // Retorna para evitar continuar o login
    }

    try {
      print(_passwordController.text.trim());
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _mailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      print("Usuário autenticado: ${userCredential.user?.email}");

      if (mounted) {
        ScaffoldMessenger.of(currentContext).showSnackBar(const SnackBar(
          content: Text("Login realizado com sucesso."),
          backgroundColor: Colors.green,
        ));
      }

      // Navegue para a página principal
      if (mounted) {
        Navigator.pushReplacementNamed(
            currentContext, '/home'); // Atualize conforme sua navegação
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

      if (mounted) {
        ScaffoldMessenger.of(currentContext).showSnackBar(SnackBar(
          content: Text(errorMessage),
          backgroundColor: Colors.red,
        ));
      }
    } catch (e) {
      print("Erro inesperado: $e");

      if (mounted) {
        ScaffoldMessenger.of(currentContext).showSnackBar(const SnackBar(
          content: Text("Erro inesperado. Tente novamente."),
          backgroundColor: Colors.red,
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quem e você?"),
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextField(
                  style: const TextStyle(fontSize: 20),
                  controller: _mailController,
                  decoration: const InputDecoration(
                      labelText: "E-mail", border: OutlineInputBorder()),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                      labelText: "Senha", border: OutlineInputBorder()),
                  obscureText: true,
                ),
                const SizedBox(
                  height: 16,
                ),
                ElevatedButton(onPressed: _login, child: const Text("Entrar")),
              ],
            ),
          )),
    );
  }
}
