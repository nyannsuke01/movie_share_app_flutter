import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movie_share_app/view/pages/favorite_page.dart';
import 'package:movie_share_app/view/pages/home_page.dart';
import 'package:movie_share_app/view/pages/login.dart';
import 'package:movie_share_app/view/pages/welcome.dart';

FirebaseAuth _auth = FirebaseAuth.instance;

class Navigation extends StatefulWidget {
  @override
  _NavState createState() => _NavState();
}

class _NavState extends State<Navigation> {
  int _selectedIndex = 0;
  @override
  void initState() {
    super.initState();
    _checkUser();
  }

  final List _widgetOptions = [
    HomePage(),
    FavoritePage(),
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

  void _checkUser(){
    //login check currentUser ありWelcome なしLogin画面
    if (_widgetOptions.length == 3) {
      _widgetOptions[2] == null;
    }
    if (_auth.currentUser == null) {
      _widgetOptions.add(Login());
      print("_widgetOptions Login currentUser == null");
      print(_widgetOptions);
    } else {
      _widgetOptions.add(Welcome(user_id: _auth.currentUser.uid));
      print("_widgetOptions Welcome currentUser != null");
      print(_widgetOptions);
    }
  }
}