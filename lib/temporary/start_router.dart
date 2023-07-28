import 'package:data_project/provider/new_user_provider.dart';
import 'package:data_project/screens/home/home.dart';
import 'package:data_project/screens/start/app_start.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StartRouter extends StatefulWidget {
  const StartRouter({super.key});

  @override
  State<StartRouter> createState() => _StartRouterState();
}

class _StartRouterState extends State<StartRouter> {
  @override
  Widget build(BuildContext context) {
    if (context.read<NewUserProvider>().isNewUser){
      return AppStartScreen();
    }else{
      return HomeScreen();
    }
    
  }
}