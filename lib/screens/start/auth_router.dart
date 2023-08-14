import 'package:data_project/firestoremodel/profile_controller.dart';
import 'package:data_project/screens/home/home.dart';
import 'package:data_project/screens/start/terms.dart';
import 'package:data_project/screens/start/app_start.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthRouter extends StatefulWidget {
  const AuthRouter({super.key});
  @override
  State<AuthRouter> createState() => _AuthRouterState();
}

class _AuthRouterState extends State<AuthRouter> {
  final UserDataController controller = Get.put(UserDataController());

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        UserDataController().to.authStateChanges(snapshot.data);
        if(!snapshot.hasData){
          return AppStartScreen();
        }else if(controller.checkHasPassword()){
          return TermsScreen();
        }else {
          return HomeScreen();
        }
      },
    );
  }
}