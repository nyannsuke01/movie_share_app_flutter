
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../repository/apiService.dart';

class DetailViewModel {
  var _fireStore = FirebaseFirestore.instance.collection;
  var _movieId = [];

  Future<String> getName() async {
    var _name = "";
    var result = await _fireStore('movie_users').get();
    result.docs.forEach((doc) {
      print("***debug--");
      print("***user_id, ${doc.id}");
      print(doc['name']);
      _name = doc['name'];
    });
    return _name;
  }

  Future<void> getResultString() async {
    var uid = FirebaseAuth.instance.currentUser?.uid;
    var result = await _fireStore('movie_users').doc(uid);
    print(result);
  }

  Future<void> getMovieIds() async {
    var uid = FirebaseAuth.instance.currentUser?.uid;
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    var result = await _fireStore('movie_users').get();
    result.docs.forEach((doc) {
      print("***debug--");
      print("***user_id, ${doc.id}");
      print(doc['name']);
      print("***uid");
      print(doc['uid']);
      if (uid == doc['uid']) {
        print("***movie_id");
        print(doc['movie_id']);
        _movieId = doc['movie_id'];

        //SharedPreferencesに保存
        List<String> strList = _movieId.map((i) => i.toString()).toList();
        print("***strList ${strList}");
        prefs.setStringList("movieId", strList);
        print("***setStringList後 ${strList}");

      }
    });
  }

  Future<void> saveFavoriteMovieId(int movieId) async {
    var result = await _fireStore('movie_users').get();
    result.docs.forEach((doc) {
      _fireStore('movie_users').doc("${doc.id}").update({
        "movie_id": FieldValue.arrayUnion([movieId])
      }) .then((value) => print('ドキュメントを更新しました！')).catchError((e) => print(e));
      print("***debug--");
      print("***user_id, ${doc.id}");
      print(doc['name']);
    });
  }

  Future<void> deletaFavoriteMovieId(int movieId) async {
    var result = await _fireStore('movie_users').get();
    result.docs.forEach((doc) {
      _fireStore('movie_users').doc("${doc.id}").update({
        "movie_id": FieldValue.arrayRemove([movieId])
      }) .then((value) => print('ドキュメントを削除しました！')).catchError((e) => print(e));
      print("***debug--");
      print("***user_id, ${doc.id}");
      print(doc['name']);
    });
  }

}
