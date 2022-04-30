import 'package:flutter/material.dart';
import '../../Const/const.dart';
import '../../model/ResponseMovieDetail.dart';

Widget? detailItem(ResponseMovieDetail? detail) {
  if (detail == null) return null;
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
                height: 300.0,
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
              GestureDetector(
                onTap: () => print('Navigate to profile'),
                child: CircleAvatar(
                  // foregroundImage: NetworkImage(video.author.profileImageUrl),
                ),
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Text(
                        detail.title ?? "",                                      // '${video.author.username} • ${video.viewCount} views • ${timeago.format(video.timestamp)}',
                        maxLines: 2,
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
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: const Icon(Icons.more_vert, size: 20.0),
              ),
            ],
          ),
        )
      ],
    ),
  );
}
