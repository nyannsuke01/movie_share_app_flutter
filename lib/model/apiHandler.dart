import 'dart:convert' as convert;
import 'dart:io';
import 'package:http/http.dart' as http;
import 'ResponseMovieDetail.dart';
import 'ResponseMovieSearch.dart';
import '../Const/api_const.dart';
import '../Const/const.dart';


Future fetchMovieList(Function(ResponseMovieSearch res) action) async {
  await fetch(baseUrl + "discover/movie?&" + apiKey, (json) {
    action(ResponseMovieSearch.fromJson(json));
  });
}
//TODO: dioに置き換え
Future fetchMovieDetail(int id, Function(ResponseMovieDetail res) action) async {
  await fetch(baseUrl + "movie/" + id.toString() + "?&" + apiKey, (json) {
    action(ResponseMovieDetail.fromJson(json));
  });
}

double checkDouble(dynamic value) {
  if (value is String) {
    return double.parse(value);
  } else if (value is int) {
    return value.toDouble();
  } else {
    return value;
  }
}

Future fetch(String url, Function(Map<String, dynamic> json) action) async {
  try {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      print(url + "  APIレスポンス::" + response.body);
      final parsed = convert.jsonDecode(response.body) as Map<String, dynamic>;
      action(parsed);
    }
  } on SocketException {
    print("ネットワークの接続がありません");
  }
}


