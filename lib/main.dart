import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'Const/const.dart';
import 'detail.dart';
import 'model/ResponseMovieSearch.dart';
import 'model/apiHandler.dart';
import 'navigation.dart';

//Future <void>
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}
Future<void> getASync() async {
  var result = await FirebaseFirestore.instance.collection('memo').get();
  result.docs.forEach((doc) {
    print("***debug--");
    print(doc.id);
    print(doc['title']);
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Navigation(),

      ),
    );
  }
}
