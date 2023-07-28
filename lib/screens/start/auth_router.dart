import 'package:data_project/provider/new_user_provider.dart';
import 'package:data_project/screens/home/home.dart';
import 'package:data_project/screens/start/terms.dart';
import 'package:data_project/screens/start/app_start.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthRouter extends StatefulWidget {
  const AuthRouter({super.key});
  @override
  State<AuthRouter> createState() => _AuthRouterState();
}

class _AuthRouterState extends State<AuthRouter> {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if(!snapshot.hasData){
          return AppStartScreen();
        }else if(context.read<NewUserProvider>().isNewUser){
          return TermsScreen();
        }else {
          return HomeScreen();
        }
      },
    );
  }
}