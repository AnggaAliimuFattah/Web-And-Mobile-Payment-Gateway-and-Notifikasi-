import 'package:flutter/material.dart';
import 'package:school_ypi_new_two/pages/dashboard_page.dart';
import 'package:school_ypi_new_two/pages/profile_page.dart';

class HomePage extends StatefulWidget {
  final String url;
  final String uuid;
  final String nama;
  final String username;
  final String token;
  const HomePage({
    Key? key,
    required this.url,
    required this.uuid,
    required this.nama,
    required this.username,
    required this.token,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  late String url;
  late String uuid;
  late String nama;
  late String username;
  late String token;
  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    url = widget.url;
    uuid = widget.uuid;
    nama = widget.nama;
    username = widget.username;
    token = widget.token;
    _pages = [
      DashboardPage(
        url: url,
        uuid: uuid,
        nama: nama,
        username: username,
        token: token,
      ),
      ProfilePage(url: url, uuid: uuid),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<BottomNavigationBarItem> _bottomItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.dashboard_outlined),
      activeIcon: Icon(Icons.dashboard),
      label: 'Dashboard',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person_outline),
      activeIcon: Icon(Icons.person),
      label: 'Profil',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: Duration(milliseconds: 300),
        child: _pages[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: _bottomItems,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.indigo,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
      ),
    );
  }
}
