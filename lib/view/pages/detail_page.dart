import 'package:flutter/material.dart';
import '../../Const/const.dart';
import '../../model/ResponseMovieDetail.dart';
import '../../service/apiService.dart';
import '../widget/detail_item.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class MovieDetail extends StatelessWidget {
  final int id;
  const MovieDetail(this.id, {Key? key}) : super(key: key);

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
  const MovieDetailPage(this.id, {Key? key, required this.title}) : super(key: key);
  final int id;
  final String title;

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState(id);
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  _MovieDetailPageState(this.id);
  ResponseMovieDetail? _movieDetail = null;
  final int id;
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
  }
  final myController = TextEditingController();
  final myFocusNode = FocusNode();
  final _screenShotController = ScreenshotController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_movieDetail?.title ?? ""),
        backgroundColor: Colors.redAccent,
      ),
      body: SingleChildScrollView(
        child: Column(
            children: <Widget>[
              Container(
                  height: 480,
                  width: 500,
                  child: detailItem(_movieDetail)
              ),
              // TODO: Star 追加

              TextField(
                controller: myController,
                decoration: InputDecoration(
                  hintText: 'コメントを入れてシェアしよう！',
                ),
                onTap: () {
                  // TODO: ここにフォーカスするためのコードを書く
                  myFocusNode.requestFocus();
                },
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
            ]
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
  void _share() async {
    print("Share Button Tapped");
    const _shareText = 'シェアするテキスト';
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

