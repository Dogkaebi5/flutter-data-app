import 'package:data_project/firebase_options.dart';
import 'package:data_project/provider/new_user_provider.dart';
import 'package:data_project/provider/user_basic_data_provider.dart';
import 'package:data_project/provider/user_interest_data_provider.dart';
import 'package:data_project/screens/start/authentication.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => NewUserProvider()),
      ChangeNotifierProvider(create: (_) => UserBasicData()),
      ChangeNotifierProvider(create: (_) => UserInterestData()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Data Pro',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: Authentication(),
    );
  }
}