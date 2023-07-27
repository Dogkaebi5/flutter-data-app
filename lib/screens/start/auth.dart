import 'package:data_project/screens/start/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if(!snapshot.hasData){
            return SignInScreen(
              providerConfigs: const [
                EmailProviderConfiguration(),
              ],
            );
          }
          return Authentication();
        }
      )
    );
  } 
}