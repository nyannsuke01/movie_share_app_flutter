import 'package:flutter/material.dart';

import 'dark_theme.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text("Movie Share App"),
        actions: [IconButton(
          icon: Icon(Icons.settings),
          onPressed: () {
          },
        ),],
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Text(
                'Movie Share App',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.redAccent,
              ),
            ),
            ListTile(
              title: Text('Dark Mode'),
              onTap: () async {
                await Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) {
                    return CangeThemePage();
                  }),
                );
              },
            ),
            ListTile(
              title: Text('Honolulu'),
              onTap: () {

              },
            ),
            ListTile(
              title: Text('Dallas'),
              onTap: () {

              },
            ),
          ],
        ),
      ),

    );
  }
}