
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteViewModel {
  var _fireStore = FirebaseFirestore.instance.collection;
  var _movieId = [];

  Future<void> getMovieIds() async {
    var uid = FirebaseAuth.instance.currentUser?.uid;
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    var result = await _fireStore('movie_users').get();
    result.docs.forEach((doc) {
      if (uid == doc['uid']) {
        _movieId = doc['movie_id'];
        //SharedPreferencesに保存
        List<String> strList = _movieId.map((i) => i.toString()).toList();
        prefs.setStringList("movieId", strList);
      }
    });
  }
}