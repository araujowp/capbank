import 'package:capbank/pages/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final onPrimaryColor = Theme.of(context).colorScheme.onPrimary;
    return MaterialApp(
      title: 'Capbank',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF446129), //
            onPrimary: Colors.white,
          ),
          fontFamily: 'Adlam Display',
          textTheme: const TextTheme(
            titleLarge: TextStyle(fontSize: 32, color: Color(0xFF446129)),
            titleSmall: TextStyle(fontSize: 32, color: Color(0xFF91A55F)),
            bodyLarge: TextStyle(fontSize: 32, color: Color(0xFF91A55F)),
          ),
          useMaterial3: true,
          appBarTheme: AppBarTheme(
            backgroundColor: const Color(0xFF446129),
            foregroundColor: onPrimaryColor,
            elevation: 2,
          ),
          scaffoldBackgroundColor: Colors.white,
          cardColor: Colors.white),
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
