import 'package:flutter/material.dart';
import 'package:flutter_academy_graduation/view/pages/dark_theme.dart';
import 'package:provider/provider.dart';
import '../../util/app_theme.dart';
import '../widget/list_item.dart';
import '../../main.dart';
import '../../model/ResponseMovieSearch.dart';
import '../../repository/apiService.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
