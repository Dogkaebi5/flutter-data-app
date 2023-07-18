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
      body : SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/datas.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(right: 20, left: 20),
            child: Column(
              children : [
                Spacer(),
                Image(
                  image: AssetImage("assets/text.png"),
                  width: 200,
                  
                ),
                Spacer(),
                Container(
                  width: double.infinity,
                  height: 180,
                  padding: EdgeInsets.all(20),
                  margin: EdgeInsets.only(bottom: 40),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white.withOpacity(.8),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Spacer(),
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
                    ]),
                ),
              ]
            ),
          ),
        ),
      ),
    );
  }
}