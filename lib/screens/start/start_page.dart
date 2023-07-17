import 'package:data_project/screens/start/firebase.dart';
import 'package:data_project/screens/webview/webview.dart';
import 'package:flutter/material.dart';

class AppStart extends StatefulWidget {
  const AppStart({super.key});

  @override
  State<AppStart> createState() => _AppStartState();
}

class _AppStartState extends State<AppStart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("시작하기")),
      body : Center(
        child: Padding(
          padding: const EdgeInsets.only(right: 20, left: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.asset('assets/siba.png', fit: BoxFit.cover),
              Column(
                children : [
                  SizedBox(
                    width: double.infinity, 
                    height: 44, 
                    child: ElevatedButton(
                      onPressed:(){
                        Navigator.push(
                          context, 
                          MaterialPageRoute(builder: (context) => const AuthPage()),
                        );
                      }, 
                      child: Text("본인인증"), 
                    )
                  ),
                  TextButton(
                    onPressed: (){
                      Navigator.push(
                        context, 
                        MaterialPageRoute(builder: (context) => const Webview()),
                      );
                    }, 
                    child: Text('고객센터', 
                    style: TextStyle(
                      decoration: TextDecoration.underline),
                    )
                  ),
                ]
              ),
            ]
          ),
        ),
      ),
    );
  }
}