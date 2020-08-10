import 'package:appnewv1/email_signin.dart';
import 'package:appnewv1/email_signup.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;

  void toggleView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return C_emailSignin(toggleView);
    } else {
      return C_emailSignup(toggleView);
    }
  }
}