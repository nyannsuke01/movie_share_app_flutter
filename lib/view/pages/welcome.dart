import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// [Themelist] インスタンスにおける処理。
class Welcome extends StatelessWidget {

  final String user_id;
  Welcome({Key? key, required this.user_id}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body:Center(
        child:Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('ようこそ',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text(user_id),
          ],
        ),
      ),
    );
  }
}