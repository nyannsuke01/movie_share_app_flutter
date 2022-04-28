
import 'package:flutter/material.dart';

import '../../Const/const.dart';
import '../../model/ResponseMovieSearch.dart';
import '../pages/detail_page.dart';

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