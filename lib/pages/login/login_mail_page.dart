// ignore_for_file: avoid_print

import 'package:capbank/business/login_business.dart';
import 'package:capbank/pages/balance/balance_page.dart';
import 'package:capbank/service/user/user_dto.dart';
import 'package:flutter/material.dart';

class LoginMailPage extends StatefulWidget {
  const LoginMailPage({super.key});

  @override
  State<LoginMailPage> createState() => _LoginMailPageState();
}

class _LoginMailPageState extends State<LoginMailPage> {
  final TextEditingController _mailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login() async {
    if (!mounted) return;

    if (_mailController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Preencha e-mail e senha."),
        backgroundColor: Colors.red,
      ));
      return;
    }

    try {
      LoginBusiness loginBusiness = LoginBusiness();
      UserDTO userDTO = await loginBusiness.login(
          _mailController.text, _passwordController.text);

      print('------------------------------');
      print(userDTO.toString());
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Login realizado com sucesso."),
        backgroundColor: Colors.green,
      ));

      print(" -----> assets/images/${userDTO.photo} ?");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => BalancePage(
            id: userDTO.id,
            name: userDTO.name,
            photo: "assets/images/${userDTO.photo}",
          ),
        ),
      );
    } catch (e) {
      if (!mounted) return;

      String errorMessage = e.toString(); // Converte o erro em string
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(errorMessage),
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
