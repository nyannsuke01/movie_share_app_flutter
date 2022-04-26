import 'package:flutter/material.dart';
import 'Const/const.dart';
import 'model/ResponseMovieDetail.dart';
import 'model/apiHandler.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),

      ),
      body: Center(
        child: Container(
            height: double.infinity,
            width: double.infinity,
            child: detailItem(_movieDetail)
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
  Widget? detailItem(ResponseMovieDetail? detail) {
    if (detail == null) return null;
    final posterPath = detail.posterPath;
    return Card(
      child: ListTile(
        title: Text(detail.title ?? ""),
        leading: Image.network(posterPath != null ? imagePath + posterPath : "",
            errorBuilder: (context, error, stackTrace) {
              return const Text("画像\nなし");
            }),
      ),
    );
  }
}

