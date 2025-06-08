import 'package:capbank/business/login_business.dart';
import 'package:capbank/pages/home/home_page.dart';
import 'package:capbank/service/user/user_dto.dart';
import 'package:capbank/util/security_storage.dart';
import 'package:capbank/util/util_message.dart';
import 'package:flutter/material.dart';

class LoginMailPage extends StatefulWidget {
  final bool showAppBar;

  const LoginMailPage({super.key, this.showAppBar = true});

  @override
  State<LoginMailPage> createState() => _LoginMailPageState();
}

class _LoginMailPageState extends State<LoginMailPage> {
  final TextEditingController _mailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login() async {
    if (!mounted) return;

    if (_mailController.text.trim().isEmpty ||
        _passwordController.text.trim().isEmpty) {
      UtilMessage().show(context, "Preencha e-mail e senha.",
          messageType: MessageType.error);
      return;
    }

    try {
      LoginBusiness loginBusiness = LoginBusiness();
      UserDTO userDTO = await loginBusiness.login(
          _mailController.text.trim(), _passwordController.text.trim());

      if (!mounted) return;

      UtilMessage().show(
        context,
        "Login realizado com sucesso!.",
      );

      SecureStorage.saveLogin(
          _mailController.text.trim(), _passwordController.text.trim());

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(
            id: userDTO.id,
            name: userDTO.name,
            photo: "assets/images/${userDTO.photo}",
          ),
        ),
      );
    } catch (e) {
      if (!mounted) return;

      String errorMessage = e.toString();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(errorMessage),
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  void initState() {
    super.initState();
    _loadLoginData();
  }

  Future<void> _loadLoginData() async {
    final loginData = await SecureStorage.getLogins();

    if (loginData['username'] != null && loginData['password'] != null) {
      setState(() {
        _mailController.text = loginData['username']!;
        _passwordController.text = loginData['password1']!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.showAppBar
          ? AppBar(
              title: const Text("Quem e você?"),
            )
          : null,
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
