import 'package:appnewv1/helpers/helperfunctions.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:appnewv1/modal/email_user.dart';
//import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';


String errorMessage;

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(userId: user.uid) : null;
  }

//sign up
  Future signUpWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email.trim(), password: password.trim());
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return e.code;
    }
  }

  //sign in
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email.trim(), password: password.trim());
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return e.code;
    }
  }

  Future resetPass(String email) async {
    try {
      return await _auth.sendPasswordResetEmail(email: email.trim());
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future email_signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

/*
  Future fb_signOut() async {
    try {
      return await FacebookAuth.instance.logOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
*/

}
