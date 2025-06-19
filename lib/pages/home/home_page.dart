import 'package:capbank/components/custom_title.dart';
import 'package:capbank/pages/balance/balance_page.dart';
import 'package:capbank/pages/login/login_list.dart';
import 'package:capbank/pages/login/login_mail_page.dart';
import 'package:capbank/pages/new_category_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final int id;
  final String name;
  final String photo;

  const HomePage({
    super.key,
    required this.id,
    required this.name,
    required this.photo,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  late List<Widget> _pages;
  late List<String> _titles;

  @override
  void initState() {
    super.initState();
    _pages = [
      BalancePage(id: widget.id, name: widget.name, photo: widget.photo),
      NewCategoryPage(widget.photo),
      const LoginMailPage(showAppBar: false),
      const LoginListPage()
    ];

    _titles = [
      'Olá ${widget.name}',
      'Nova Categoria',
      'Quem é você?',
      'Escolha'
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomTitle(_titles[_currentIndex], widget.photo),
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category_outlined),
            label: 'Categoria',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Login',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.groups),
            label: 'Logins',
          ),
        ],
      ),
    );
  }
}
