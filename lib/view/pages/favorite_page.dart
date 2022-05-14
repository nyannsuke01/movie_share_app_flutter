import 'package:flutter/material.dart';

import '../../model/ResponseMovieSearch.dart';
import '../../repository/apiService.dart';
import '../widget/list_item.dart';
import 'dark_theme.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);
  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  List<Results> _movieList = [];

  void fetchListData() {
    fetchMovieList((res) {
      final result = res.results;
      if (result != null) {
        setState(() {
          _movieList = result;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    fetchListData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text("Favorite"),
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
              title: Text('Settings'),
              onTap: () {

              },
            ),
            ListTile(
              title: Text('User policy'),
              onTap: () {

              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Container(
            height: double.infinity,
            width: double.infinity,
            child: ListView.builder(
              itemCount: _movieList.length,
              itemBuilder: (listContext, idx) {
                final _movie = _movieList[idx];
                return listItem(context, _movie);
              },
            )),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}