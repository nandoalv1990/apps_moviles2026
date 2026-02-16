import 'dart:async';
//import 'dart:html';
//import 'dart:ffi';
import 'package:firebase_auth/firebase_auth.dart';
//https://devcodelight.com/como-recuperar-contrasena-olvidada-con-flutter-y-firebase/
//https://firebase.google.com/docs/auth/flutter/password-auth?hl=es-419#create_a_password-based_account

class EmailAuth {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // ignore: non_constant_identifier_names
  Future<bool> CreateUser(String email, String password) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      credential.user!.sendEmailVerification();
      return true;
    } catch (e) {
      // ignore: avoid_print
      print(e);
      return false;
    }
  }

  // ignore: non_constant_identifier_names
  Future<bool> VerifyEmail(String email, String password) async {
    try {
      // ignore: non_constant_identifier_names
     // final credential = await _auth.signInWithEmailAndPassword( email: email, password: password);
      _auth.currentUser?.sendEmailVerification();
      //credential.user!.sendEmailVerification();
      return true;
    } catch (e) {
      return false;
    }
  }

  // ignore: non_constant_identifier_names
  Future<int> ValidateUser(String email, String password) async {
    try {
      // ignore: non_constant_identifier_names
      final credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (credential.user!.uid != '') {
        return 1;
      } else {
        //Bonus:
        if (credential.user!.emailVerified) {
          return 0;
        }
      }
      return 2;
    } catch (e) {
      // ignore: avoid_print
      print(e);
      return 3;
    }
  }

//Tarea: crear pantalla para recuperar el password
  // ignore: non_constant_identifier_names
  Future<bool> ResetPass(String email) async {
    try {
      // ignore: unused_local_variable
      final credential = await _auth.sendPasswordResetEmail(email: email);
      return true;
    } catch (e) {
      // ignore: avoid_print
      print(e);
      return false;
    }
  }
}
