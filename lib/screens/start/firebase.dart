import 'package:data_project/screens/start/service_terms.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SignPage(),
    );
  }
}

class SignPage extends StatelessWidget {
  const SignPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if(!snapshot.hasData){
          return SignInScreen(
            providerConfigs: const [
              EmailProviderConfiguration(),
              // GoogleProviderConfiguration(clientId: ""),
            ],
          );
        }
        return Terms();
      }
    );
  } 
}