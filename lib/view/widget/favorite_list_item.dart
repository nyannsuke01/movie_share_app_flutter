
import 'package:flutter/material.dart';

import '../../Const/const.dart';
import '../../model/ResponseMovieDetail.dart';
import '../../model/ResponseMovieSearch.dart';
import '../../view_model/detail_view_model.dart';
import '../pages/detail_page.dart';
import 'package:cached_network_image/cached_network_image.dart';

Widget favoritelistItem(BuildContext context, ResponseMovieDetail detail) {
  if (detail == null) return null;
  final posterPath = detail.posterPath;

  return Card(
    child: ListTile(
      title: Text(detail.title ?? ""),
      leading: CachedNetworkImage(
        imageUrl: posterPath != null ? mainImagePath + posterPath : "",
        placeholder: (context, url) => CircularProgressIndicator(),
        errorWidget: (context, error, stackTrace) {
          return const Text("No\nImage");
        },
      ),
      onTap: () {
        final id = detail.id;
        if (id != null) {
        }
      },
    ),
  );
}