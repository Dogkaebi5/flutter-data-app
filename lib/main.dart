import 'package:data_project/data/password_setter.dart';
import 'package:data_project/firebase_options.dart';
import 'package:data_project/screens/home/home.dart';
import 'package:data_project/screens/start/service_terms.dart';
import 'package:data_project/screens/start/start_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
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
      home: Authentication(storage: PasswordStorage(),),
    );
  }
}

class Authentication extends StatefulWidget {
  const Authentication({super.key, required this.storage});
  
  final PasswordStorage storage;

  @override
  State<Authentication> createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  String _password = "";
  bool isUserHasPassword(){
    if(_password.length >=4){ 
      return true;
    }else{ 
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    widget.storage.readPassword().then((value){
      setState(() {
        _password = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if(!snapshot.hasData){
          return AppStart();
        }else if(!isUserHasPassword()) {
          return Terms();
        }else {
          return HomePage();
        }
      },
    );
  }
}