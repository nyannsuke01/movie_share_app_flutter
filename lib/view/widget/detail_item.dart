import 'package:flutter/material.dart';
import '../../Const/const.dart';
import '../../model/ResponseMovieDetail.dart';

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
