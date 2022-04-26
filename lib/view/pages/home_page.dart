import 'package:flutter/material.dart';
import '../../detail.dart';
import '../../main.dart';
import '../../model/ResponseMovieSearch.dart';
import '../../model/apiHandler.dart';
import '../../Const/const.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);
  final String title;

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
          getASync();
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
        title: Text(widget.title),
      ),
      body: Center(
        child: Container(
            height: double.infinity,
            width: double.infinity,
            child: ListView.builder(
              itemCount: _movieList.length,
              itemBuilder: (listContext, idx) {
                return listItem(context, _movieList[idx]);
              },
            )),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget listItem(BuildContext context, Results result) {
    final posterPath = result.posterPath;
    return Card(
      child: ListTile(
        title: Text(result.title ?? ""),
        leading: Image.network(posterPath != null ? mainImagePath + posterPath : "",
            errorBuilder: (context, error, stackTrace) {
              return const Text("画像\nなし");
            }),
        onTap: () {
          final id = result.id;
          if (id != null) {
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MovieDetail(id)));
          }
        },
      ),
    );
  }
}
