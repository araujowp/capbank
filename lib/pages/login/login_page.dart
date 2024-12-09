import 'package:capbank/pages/login/widget/user_avatar.dart';
import 'package:capbank/pages/balance/balance_page.dart';
import 'package:capbank/service/user/user_service.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  final UserService userService = UserService();
  LoginPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quem é você?'),
      ),
      body: FutureBuilder(
        future: userService.fetchUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Erro ao carregar os dados.'));
          } else {
            final users = snapshot.data!;
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return UserAvatar(
                  id: user.id,
                  name: user.name,
                  photo: user.photo,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BalancePage(
                          id: user.id,
                          name: user.name,
                          photo: user.photo,
                        ),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
