import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../model/ResponseMovieDetail.dart';
import '../../navigation.dart';
import '../../repository/apiService.dart';
import '../widget/detail_item.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'favorite_page.dart';

class MovieDetail extends StatelessWidget {
  final int id;
  const MovieDetail(this.id, {Key key}) : super(key: key);

  get voteAverage => null;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MovieDetailPage(id, title: 'detail'),
    );
  }
}

class MovieDetailPage extends StatefulWidget {
  const MovieDetailPage(this.id, {Key key, this.title}) : super(key: key);
  final int id;
  final String title;

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState(id);
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  final _screenShotController = ScreenshotController();
  _MovieDetailPageState(this.id);
  ResponseMovieDetail _movieDetail = null;
  final int id;
  FirebaseAuth _auth = FirebaseAuth.instance;
  var _isFavorite = false;
  void fetchDetailData(int id) {
    fetchMovieDetail(id, (res) {
      setState(() {
        _movieDetail = res;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    fetchDetailData(id);

    if (_auth.currentUser != null) {
      // viewModel.getResultString();
      print("getMovieIds");
      viewModel.getMovieIds();
      Future(() async {
        final prefs = await SharedPreferences.getInstance();
        List<String> savedStrList = prefs.getStringList('movieId');
        List<int> intProductList = savedStrList.map((i) => int.parse(i)).toList();
        // 保存したMovieIdに現在のidが含まれていたら、お気に入り
        if(intProductList.contains(id)){
          _isFavorite = true;
        }
      });
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Screenshot(
      controller: _screenShotController,
      child: Scaffold(
        appBar: AppBar(
          title: Text(_movieDetail?.title ?? ""),
          backgroundColor: Colors.redAccent,
        ),
        body: SingleChildScrollView(
          child: Column(
              children: <Widget>[
                Container(
                    height: 630,
                    width: 500,
                    child: detailItem(_movieDetail, _isFavorite)
              ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      child: const Text(' back '),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blueAccent,
                        onPrimary: Colors.black,
                        shape: const StadiumBorder(),
                      ),
                      onPressed: () async {
                        await Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) {
                            return Navigation();
                          }),
                        );
                      },
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(
                      child: const Text('Share'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.redAccent,
                        onPrimary: Colors.black,
                        shape: const StadiumBorder(),
                      ),
                      onPressed: () {
                        _share();
                      },
                    ),
                  ],
                )
            ]
          ),
        ),
      ),
    );
  }
  void _share() async {
    print("Share Button Tapped");
    var _shareText = _movieDetail.title as String;
    final _screenshot = await _screenShotController.capture(
        delay: const Duration(milliseconds: 10));

    if (_screenshot != null) {
      // スクリーンショットをドキュメントディレクトリに保存
      final _documentDirectoryPath = await getApplicationDocumentsDirectory();
      final imagePath = await File(
          '${_documentDirectoryPath.path}/screenshot.png').create();
      await imagePath.writeAsBytes(_screenshot);
      // スクリーンショットとテキストをシェア
      await Share.shareFiles([imagePath.path], text: _shareText);
    }
  }
}

