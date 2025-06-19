import 'package:capbank/pages/login/login_mail_page.dart';
import 'package:capbank/util/security_storage.dart';
import 'package:flutter/material.dart';

class LoginListPage extends StatelessWidget {
  const LoginListPage({super.key});

  Future<void> _handleTap(
      BuildContext context, String username, String? password) async {
    await SecureStorage.saveLogin(
        username, password!); // Assumindo que saveLogin é async
    //await Future.delayed(const Duration(seconds: 1)); // Agora o await funciona
    if (context.mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginMailPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Usuarios'),
      ),
      body: FutureBuilder<Map<String, String?>>(
        future: SecureStorage.getLogins(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading logins'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No logins found'));
          }

          final logins = snapshot.data!;
          return ListView.builder(
            itemCount: logins.length,
            itemBuilder: (context, index) {
              final username = logins.keys.elementAt(index);
              final password = logins[username];
              return ListTile(
                title: Text(username, style: const TextStyle(fontSize: 18)),
                subtitle: Text(password!),
                onTap: () => _handleTap(context, username, password),
              );
            },
          );
        },
      ),
    );
  }
}
