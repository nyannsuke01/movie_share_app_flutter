import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../model/ResponseMovieDetail.dart';
import '../../repository/apiService.dart';
import '../../view_model/detail_view_model.dart';
import '../widget/favorite_list_item.dart';
import 'dark_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

FirebaseAuth _auth = FirebaseAuth.instance;
final viewModel = DetailViewModel();

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key key}) : super(key: key);

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  //Result型だから違う　
  // ResponseMovieDetail _movieDetail = null;
  List<ResponseMovieDetail> _movieList = [];


  void fetchDetailData(int id) {
    fetchMovieDetail(id, (res) {
      setState(() {
        // _movieDetail = res;
        _movieList.add(res);
        print("*_movieList* ${_movieList[1].title}");
      });
    });
  }

  @override
  void initState() {
    super.initState();
    if (_auth.currentUser != null) {
      // viewModel.getResultString();
      print("getMovieIds");
      viewModel.getMovieIds();
      Future(() async {
        final prefs = await SharedPreferences.getInstance();
        List<String> savedStrList = prefs.getStringList('movieId');
        print("*savedStrList* ${savedStrList}");
        List<int> intProductList = savedStrList.map((i) => int.parse(i)).toList();
        print("*intProductList** ${intProductList}");
        // そのmovie_idでAPIを叩き、List で表示する
        for (var movieId in intProductList) {
          //取得したmovieIdを元にYoutube検索情報を取得
          fetchDetailData(movieId);
        }
      });
    }
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
              shrinkWrap: true,
              itemCount: _movieList.length,
              itemBuilder: (listContext, idx) {
                final _movie = _movieList[idx];
                print("*_movie* ${_movie}");
                return favoritelistItem(context, _movie);
              },
            )
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}