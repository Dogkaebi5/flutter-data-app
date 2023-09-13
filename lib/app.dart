import 'package:data_project/screens/start/auth_router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot){
        if(snapshot.hasError){
          return Center(child: Text("구글 서버 연결을 실패했습니다."));
        }
        if(snapshot.connectionState == ConnectionState.done){
          return AuthRouter();
        }
        return Center(child: CircularProgressIndicator());
      });
  }
}