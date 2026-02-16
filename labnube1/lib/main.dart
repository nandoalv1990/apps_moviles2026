import 'package:flutter/material.dart';
import 'package:labnube1/screens/getpass.dart';
import 'package:labnube1/screens/login_screen.dart';
import 'package:labnube1/screens/register_screen.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:cloud_firestore_web/cloud_firestore_web.dart';
import 'package:firebase_core/firebase_core.dart';
//import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
      routes: {
        '/register': (context) => const RegisterScreen(),
        '/main': (context) => const MyApp(),
        '/getpass': (context) => ResetPass(),
        //'/dash': (context) => screen(),
      },
    );
  }
}
