
import 'package:flutter/material.dart';

import '../../Const/const.dart';
import '../../model/ResponseMovieSearch.dart';
import '../pages/detail_page.dart';
import 'package:cached_network_image/cached_network_image.dart';

Widget listItem(BuildContext context, Results result) {
  final posterPath = result.posterPath;
  return Card(
    child: ListTile(
      title: Text(result.title ?? ""),
      leading: CachedNetworkImage(
        imageUrl: posterPath != null ? mainImagePath + posterPath : "",
        placeholder: (context, url) => CircularProgressIndicator(),
        errorWidget: (context, error, stackTrace) {
            return const Text("No\nImage");
          },
      ),
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