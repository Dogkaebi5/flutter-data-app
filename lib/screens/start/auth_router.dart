import 'dart:async';

import 'package:data_project/firestoremodel/profile_controller.dart';
import 'package:data_project/screens/home/home.dart';
import 'package:data_project/screens/start/terms.dart';
import 'package:data_project/screens/start/app_start.dart';
import 'package:data_project/widgets/widget_style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthRouter extends StatelessWidget {
  AuthRouter({super.key});
  final UserDataController controller = Get.put(UserDataController());

  @override
  Widget build(BuildContext context){
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if(!snapshot.hasData){
          print("1: ${snapshot.data}");
          return AppStartScreen();
        }else {
          UserDataController().to.authStateChanges(snapshot.data);
          print("2: ${snapshot.data}");
          return Obx(() => (controller.myProfile().isNewUser == null)
            ?Stack(children: const [
              Opacity(opacity: .5, child: ModalBarrier(dismissible: false, color: Colors.black)),
              Center(child: CircularProgressIndicator(color: Colors.deepPurple))]) 
            :NewUserRouter());
        }
      }
    );
  }  
}

class NewUserRouter extends StatefulWidget {
  NewUserRouter({super.key});
  @override
  State<NewUserRouter> createState() => _NewUserRouterState();
}

class _NewUserRouterState extends State<NewUserRouter> {
  final UserDataController controller = Get.put(UserDataController());

  @override
  void initState() {
    super.initState();
    Timer(Duration(milliseconds: 1000), (){
      (controller.myProfile().isNewUser!) 
      ? navPush(context, TermsScreen())
      : navPush(context, HomeScreen());
    });
  }

  @override
  Widget build (BuildContext context) {
    return Stack(children: const [
      Opacity(opacity: .5, child: ModalBarrier(dismissible: false, color: Colors.black)),
      Center(child: CircularProgressIndicator(color: Colors.deepPurple))]);
  }
}

