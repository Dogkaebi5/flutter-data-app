import 'package:data_project/screens/webview/webview.dart';
import 'package:data_project/widgets/widget_style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
    return Spacer();
  }  

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body : SafeArea(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Stack(
            children: [
              AnimatedPositioned(
                height: size.height,
                duration: const Duration(seconds: 16),
                right: (firstAnimatedState) ? -1000 : (repeatAnimatedState) ? 0 : -999,
                curve: Curves.linear,
                onEnd: () => setState(() { repeatAnimatedState = !repeatAnimatedState; }),
                child: Image.asset('assets/data_center.png',fit:BoxFit.fitHeight,),
              ),
              Container(
                width: double.infinity,
                height: 180,
                padding: const EdgeInsets.all(20),
                margin: EdgeInsets.only(top: size.height/1.5, left: 20, right: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color.fromRGBO(255, 255, 255, 1).withOpacity(.8),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    setFirstAnimatedState(),
                    ElevatedButton(
                      style: btnStyle,
                      onPressed:signInWithGoogle, 
                      child: const Text("본인인증"), 
                    ),
                    TextButton(
                      onPressed: (){ navPush(context, Webview()); }, 
                      child: const Text('고객센터', style: TextStyle(decoration: TextDecoration.underline))
                    ),
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