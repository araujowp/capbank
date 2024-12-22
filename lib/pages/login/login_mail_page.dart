// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

class LoginMailPage extends StatefulWidget {
  const LoginMailPage({super.key});

  @override
  State<LoginMailPage> createState() => _LoginMailPageState();
}

class _LoginMailPageState extends State<LoginMailPage> {
  final TextEditingController _mailControler = TextEditingController();
  final TextEditingController _passWordControler = TextEditingController();

  void _login() {
    if (_mailControler.text.isEmpty || _passWordControler.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Preencha e-mail e senha "),
        backgroundColor: Colors.red,
      ));
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
                  controller: _mailControler,
                  decoration: const InputDecoration(
                      labelText: "E-mail", border: OutlineInputBorder()),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextField(
                  controller: _passWordControler,
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
