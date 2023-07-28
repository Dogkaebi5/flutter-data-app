import 'package:data_project/screens/start/firebase_auth.dart';
import 'package:data_project/screens/webview/webview.dart';
import 'package:flutter/material.dart';

class AppStartScreen extends StatefulWidget {
  const AppStartScreen({super.key});

  @override
  State<AppStartScreen> createState() => _AppStartScreenState();
}

class _AppStartScreenState extends State<AppStartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body : SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/data_center.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(right: 20, left: 20),
            child: Column(
              children : [
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
                              MaterialPageRoute(builder: (context) => const FirebaseAuthPage()),
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