import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../util/app_theme.dart';
import '../widget/list_item.dart';
import '../../main.dart';
import '../../model/ResponseMovieSearch.dart';
import '../../repository/apiService.dart';

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
          print("getASync();");
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
    final theme = Provider.of<AppTheme>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text(widget.title),
        leading: Switch.adaptive(
          inactiveTrackColor: Colors.deepPurple,
          activeColor: Colors.yellowAccent,
          value: theme.isDark,
          onChanged: (_) {
            theme.changeMode();
          },
        ),
        actions: [IconButton(
          icon: Icon(Icons.settings),
          onPressed: () {
            },
        ),],

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
