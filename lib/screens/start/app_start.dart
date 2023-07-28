import 'package:data_project/screens/start/firebase_auth.dart';
import 'package:data_project/screens/webview/webview.dart';
import 'package:flutter/material.dart';

class AppStartScreen extends StatefulWidget {
  const AppStartScreen({super.key});

  @override
  State<AppStartScreen> createState() => _AppStartScreenState();
}

class _AppStartScreenState extends State<AppStartScreen> {
  bool firstAnimatedState = true;
  bool repeatAnimatedState = true;
  setFirstAnimatedState(){
    setState(()=> firstAnimatedState = false);
    return SizedBox.shrink();
  }  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body : SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              AnimatedPositioned(
                height: MediaQuery.of(context).size.height,
                duration: Duration(seconds: 14),
                right: (firstAnimatedState) ? -1000 : (repeatAnimatedState) ? 0 : -999,
                curve: Curves.linear,
                onEnd: () => setState(() {
                  repeatAnimatedState = !repeatAnimatedState;
                }),
                child: Image.asset('assets/data_center.png',fit:BoxFit.fitHeight,),
              ),
              Container(
                width: double.infinity,
                height: 180,
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.only(top: MediaQuery.of(context).size.height/1.5, left: 20, right: 20),
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
                    setFirstAnimatedState()
                  ]
                ),
              ),
            ]
          ),
        ),
      )
    );
  }

}