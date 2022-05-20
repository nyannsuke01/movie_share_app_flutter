

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_academy_graduation/view/pages/login.dart';
import 'package:flutter_academy_graduation/view/pages/welcome.dart';

FirebaseAuth _auth = FirebaseAuth.instance;

class LoginCheck extends StatefulWidget{
  LoginCheck({Key key}) : super(key: key);

  @override
  _LoginCheckState createState() => _LoginCheckState();

}

class _LoginCheckState extends State<LoginCheck>{
  //ログイン状態のチェック(非同期で行う)
  void checkUser() async{
    final currentUser = await FirebaseAuth.instance.currentUser;
    if(currentUser == null){
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) {
            return Login();
          },
        ),
      );    
    }else{
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) {
            print(currentUser.uid);
            return Welcome(user_id: currentUser.uid);
          },
        ),
      );
    }
  }

  @override
  void initState(){
    super.initState();
    checkUser();
  }
  //ログイン状態のチェック時はこの画面が表示される
  //チェック終了後にホーム or ログインページに遷移する
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Text("Loading..."),
        ),
      ),
    );
  }
}