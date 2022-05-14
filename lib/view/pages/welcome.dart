import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../navigation.dart';

// [Themelist] インスタンスにおける処理。
class Welcome extends StatelessWidget {

  final String user_id;
  Welcome({Key? key, required this.user_id}) : super(key: key);
  BuildContext get context => context;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text("My Page"),
        actions: [IconButton(
          icon: Icon(Icons.settings),
          onPressed: () {
          },
        ),],
      ),
      body:Center(
        child:Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('ようこそ',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text(user_id),
            ElevatedButton(
              child: const Text('ログアウト'),
              style: ElevatedButton.styleFrom(
                primary: Colors.redAccent,
                onPrimary: Colors.black,
                shape: const StadiumBorder(),
              ),
              onPressed: () async {
                _logout();
              },
            ),
            ElevatedButton(
              child: const Text('戻る'),
              style: ElevatedButton.styleFrom(
                primary: Colors.blueAccent,
                onPrimary: Colors.black,
                shape: const StadiumBorder(),
              ),
              onPressed: () async {
                await Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) {
                    return Navigation();
                  }),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
  Future<void> _logout() async {
    // ログアウト処理
    // 内部で保持しているログイン情報等が初期化される
    // （現時点ではログアウト時はこの処理を呼び出せばOKと、思うぐらいで大丈夫です）
    await FirebaseAuth.instance.signOut();
    // ログイン画面に遷移＋チャット画面を破棄
    await Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) {
        return Navigation();
      }),
    );
  }
  // back
}