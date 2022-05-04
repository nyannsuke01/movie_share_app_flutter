import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../Const/const.dart';
import '../../model/ResponseMovieDetail.dart';
import 'package:favorite_button/favorite_button.dart';



Widget? detailItem(ResponseMovieDetail? detail) {
  if (detail == null) return null;
  final myController = TextEditingController();
  final myFocusNode = FocusNode();

  final posterPath = detail.posterPath;
  return Card(
    child:Column(
      children: [
        Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 50.0,
              ),
              child: Image.network(
                posterPath != null ? imagePath + posterPath : "",
                errorBuilder: (context, error, stackTrace) {
                  return const Text("NoImage");
                },
                height: 400.0,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(width: 8.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Text(
                        detail.title ?? "",                                      // '${video.author.username} • ${video.viewCount} views • ${timeago.format(video.timestamp)}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Flexible(
                      child: Text(
                        '${detail.overview}',
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                    ),
                    ),

                    Row(
                      children: [
                        SizedBox(
                          width: 100,
                          child: RaisedButton(
                            onPressed: () => null,
                            color: Colors.red,
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.touch_app,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    '見た',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ), //Row
                            ), //Padding
                          ), //RaisedButton
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        StarButton(
                          isStarred: true,
                          // iconDisabledColor: Colors.white,
                          valueChanged: (_isStarred) {
                            print('Is Starred : $_isStarred');
                          },
                        ),
                        Text(detail.voteAverage.toString(),
                            style: TextStyle(fontSize: 20.0),
                        ),
                        Text("/10"),

                        SizedBox(
                          width: 20,
                        ),

                        FavoriteButton(
                          isFavorite: false,
                          valueChanged: (_isFavorite) {
                            print('Is Favorite : $_isFavorite');
                          },
                        ),
                      ],
                    ),
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
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    ),
  );
}
