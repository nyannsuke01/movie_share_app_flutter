// import 'package:dio/dio.dart';
// import 'package:flutter_academy_graduation/const/api_const.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// import '../Const/const.dart';
// import '../model/ResponseMovieDetail.dart';
// import '../model/ResponseMovieSearch.dart';
//
//
// final dioProvider = Provider((ref) {
//   return Dio(BaseOptions(
//     baseUrl: baseUrl,
//   ));
// });
//
// final movieTypeProvider = StateProvider((ref) => MovieType.popular);
//
// final moviesProvider = FutureProvider<List<ResponseMovieDetail>>((ref) async {
//   final movieType = ref.watch(movieTypeProvider.state).state;
//   final dio = ref.watch(dioProvider);
//   final response = await dio.get('movie/${movieType.value}',
//       queryParameters: {'api_key': apiKey});
//   return ResponseMovieSearch.fromJson(response.data).results;
//
// });
//
// final movieProvider = Provider((ref) => throw UnimplementedError());