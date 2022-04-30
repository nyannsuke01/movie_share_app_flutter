import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_academy_graduation/view/pages/favorite.dart';
import 'package:flutter_academy_graduation/view/pages/home_page.dart';
import 'package:flutter_academy_graduation/view/pages/login.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';

class Navigation extends StatefulWidget {
  @override
  _NavState createState() => _NavState();
}

class _NavState extends State<Navigation> {
  int _selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[
    HomePage(title: 'Movie App',),
    FavoritePage(),
    Login(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: ConvexAppBar(
        backgroundColor: Colors.redAccent,
        items: [
          TabItem(icon: Icons.movie, title: 'Movie'),
          TabItem(icon: Icons.favorite, title: 'Favorite'),
          TabItem(icon: Icons.person, title: 'mypage'),
        ],
        initialActiveIndex: 0,
        onTap: _onItemTap,
      ),
    );
  }

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}