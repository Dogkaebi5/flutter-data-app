import 'package:data_project/firestoremodel/profile_controller.dart';
import 'package:data_project/firebase_options.dart';
import 'package:data_project/screens/start/auth_router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'DayPlus',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      initialBinding: BindingsBuilder(() {
        Get.lazyPut(() => UserDataController());
      }),
      home: AuthRouter()
    );
  }
}