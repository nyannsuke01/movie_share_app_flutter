
import 'package:cloud_firestore/cloud_firestore.dart';

class DetailViewModel {
  var _fireStore = FirebaseFirestore.instance.collection;
  Future<void> getName() async {
    var result = await _fireStore('movie_users').get();
    result.docs.forEach((doc) {
      print("***debug--");
      print("***user_id, ${doc.id}");
      print(doc['name']);
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
