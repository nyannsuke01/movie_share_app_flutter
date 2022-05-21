import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../Const/const.dart';
import '../../model/ResponseMovieDetail.dart';
import 'package:favorite_button/favorite_button.dart';
import '../../view_model/detail_view_model.dart';

Widget detailItem(ResponseMovieDetail detail, bool _isFavorite) {
  if (detail == null) return null;
  final myController = TextEditingController();
  final myFocusNode = FocusNode();
  final viewModel = DetailViewModel();
  final posterPath = detail.posterPath;
  var _isRed = true;
  return Card(
    child:Column(
      children: [
        Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 50.0,
              ),
              child: CachedNetworkImage(
                imageUrl: posterPath != null ? imagePath + posterPath : "",
                errorWidget: (context, error, stackTrace) {
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
                          child: ElevatedButton(
                            onPressed: () =>  _isRed = !_isRed,
                            style: ElevatedButton.styleFrom(
                              primary: _isRed ? Colors.redAccent : Colors.grey,
                            ),
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
                        //お気に入りボタン
                        FavoriteButton(
                          isFavorite: _isFavorite,
                          valueChanged: (_isFavorite) {
                            print('Is Favorite : $_isFavorite');
                            var _movieId = detail.id;
                            viewModel.saveFavoriteMovieId(
                                _movieId ?? 0,
                            );
                            print('Is Favorite後');
                            viewModel.getName();
                            if (!_isFavorite){
                              viewModel.deletaFavoriteMovieId(
                                  _movieId ?? 0,
                              );
                            }
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
