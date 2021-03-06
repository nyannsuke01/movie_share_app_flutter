
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DetailViewModel {
  var _fireStore = FirebaseFirestore.instance.collection;

  Future<String> getName() async {
    var _name = "";
    var result = await _fireStore('movie_users').get();
    result.docs.forEach((doc) {
      _name = doc['name'];
    });
    return _name;
  }

  Future<void> getResultString() async {
    var uid = FirebaseAuth.instance.currentUser?.uid;
    var result = await _fireStore('movie_users').doc(uid);
    print(result);
  }

  Future<void> saveFavoriteMovieId(int movieId) async {
    var result = await _fireStore('movie_users').get();
    result.docs.forEach((doc) {
      _fireStore('movie_users').doc("${doc.id}").update({
        "movie_id": FieldValue.arrayUnion([movieId])
      }) .then((value) => print('ドキュメントを更新しました！')).catchError((e) => print(e));
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
    });
  }

}
