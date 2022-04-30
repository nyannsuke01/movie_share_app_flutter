import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_academy_graduation/util/app_theme.dart';
import 'package:provider/provider.dart';
import 'navigation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    ChangeNotifierProvider(
      create: (_) => AppTheme(),
      child: const MyApp(),
    ),
  );
}
Future<void> getASync() async {
  var result = await FirebaseFirestore.instance.collection('movie_users').get();
  result.docs.forEach((doc) {
    print("***debug--");
    print("***user_id, ${doc.id}");
    print(doc['name']);
    print(doc['videoId']);
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: Provider.of<AppTheme>(context).buildTheme(),
      home: Scaffold(
        body: Navigation(),
      ),
    );
  }
}
