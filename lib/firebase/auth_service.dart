

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../screens/snackbar.dart';




class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;


  Future<UserCredential?> signInWithEmailAndPassword({ required BuildContext context,
       required String email,  required String password}) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      print("Firebae---------------------------- ${e.code}");
      CustomSnackBar.show(context, "INVALID_LOGIN_CREDENTIALS", color: Colors.red,duration: Duration(seconds: 10));

      // if (e.code == "INVALID_LOGIN_CREDENTIALS") {
      //   CustomSnackBar.show(context as BuildContext, "Your Password is Wrong Please try again", color: Colors.red);
      //
      // } else if (e.code == "INVALID_LOGIN_CREDENTIALS") {
      //   CustomSnackBar.show(context as BuildContext, "Email not Found Please try again", color: Colors.red);
      // }

      return null;
    }
  }


  Future<UserCredential?> signUpWithEmailAndPassword({
    required BuildContext context,
      required String email, required String password, }) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on  FirebaseAuthException catch (e)  {
      print("Firebase -----------------Firebase Sign Up------------------------ $e");

      if (e.code == "unknown") {
        print("Some fild miss please double check");

      } else if (e.code == "invalid-email") {
        print("Your email format is not correct please try again");
      } else if (e.code == "weak-password") {

        CustomSnackBar.show(context , "Password should be greater then 6 digit", color: Colors.red,duration: Duration(seconds: 10));
      } else if (e.code == "email-already-in-use") {

        CustomSnackBar.show(context , "Your email already exist please try another email", color: Colors.red,duration: Duration(seconds: 10));
      }



      return null;
    }
  }

  // Sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
