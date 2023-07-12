import 'package:data_project/provider/user_data_provider.dart';
import 'package:data_project/screens/home/home.dart';
import 'package:data_project/screens/start/service_terms.dart';
import 'package:data_project/screens/start/start_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Authentication extends StatefulWidget {
  const Authentication({super.key});
  @override
  State<Authentication> createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if(!snapshot.hasData){
          return AppStart();
        }else if(context.read<NewUserProvider>().isNewUser){
          return Terms();
        }else {
          return HomePage();
        }
      },
    );
  }
}