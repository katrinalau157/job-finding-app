import 'package:appnewv1/helpers/Constants.dart';
import 'package:appnewv1/services/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

import 'package:appnewv1/screen_C/C_MainPage.dart';
import 'package:appnewv1/helpers/helperfunctions.dart';

class C_login extends StatefulWidget {
  @override
  _C_loginState createState() => _C_loginState();
}

class _C_loginState extends State<C_login> {
  dynamic _userData;
  bool userIsLoggedIn;
  DatabaseMethods databaseMethods = new DatabaseMethods();
  @override
  void initState() {
    super.initState();
  }


/*
  _login() async {
    final result = await FacebookAuth.instance.login();
    switch (result.status) {
      case FacebookAuthLoginResponse.ok:
        final userData = await FacebookAuth.instance.getUserData();

        AuthCredential credential = FacebookAuthProvider.getCredential(
            accessToken: result.accessToken.token);
        await FirebaseAuth.instance.signInWithCredential(credential);
        setState(() => _userData = userData);

        HelperFunctions.saveUserLoggedInSharedPreference(true);
        HelperFunctions.saveUserNameSharedPreference(_userData['name']);
        HelperFunctions.saveUserEmailSharedPreference(_userData['email']);
        HelperFunctions.saveUserLoggedInSharedPreference(true);

        HelperFunctions.saveUserLoggedInFB(true);
        HelperFunctions.saveUserLoggedInEmail(false);
        HelperFunctions.saveUserFBIcon(_userData['picture']['data']['url']);
        Map<String,String> userDataMap = {
          "name" : _userData['name'],
          "email" : _userData['email'],
        };

        databaseMethods.addUserInfo(userDataMap);

        _close();

        break;
      case FacebookAuthLoginResponse.cancelled:
        print("login cancelled");
        break;
      default:
        print("login failed");
        break;
    }
  }

  _logOut() async {
    await FacebookAuth.instance.logOut();
    setState(() => _userData = null);
  }
*/


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign in with Facebook'),
        backgroundColor: appBlueColor,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          (userIsLoggedIn != null && userIsLoggedIn == true)
              ? /*Column(
                  children: <Widget>[
                    Card(
                      child: Container(
                        height: 200.0,
                        width: 200.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(
                              _userData['picture']['data']['url'],
                            ),
                          ),
                        ),
                      ),
                      semanticContainer: true,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      elevation: 5,
                      margin: EdgeInsets.all(10),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Name: ${_userData['name']}\nEmail: ${_userData['email']}',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                )*/
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Loading...",
                style:
                TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center),
          )
              : Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
                "Please select a login method ",
                style:
                TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center),
          ),

/*          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: FlatButton.icon(
                icon: Icon(Icons.sentiment_satisfied),
                padding: EdgeInsets.all(16),
                textColor: Colors.white,
                color: _userData != null ? Colors.black : Colors.blue[800],
                onPressed: () => _userData != null ? _logOut() : _login(),
                label: Text(
                  _userData != null ? 'Log Out' : 'Facebook Log In',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ),
          */
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: FlatButton.icon(
                icon: Icon(Icons.email),
                padding: EdgeInsets.all(16),
                textColor: Colors.white,
                color: (userIsLoggedIn != null && userIsLoggedIn == true) ? Colors.black : Colors.grey[500],
                onPressed: () {Navigator.pushReplacementNamed(context, C_emailSigninTag);
                },
                label: Text(
                  (userIsLoggedIn != null && userIsLoggedIn == true)? 'Already login with facebook' : 'Email Log In',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void _close() {
    set_selectedindex3_C();
    Navigator.pushReplacementNamed(context, C_MainPageTag);
  }
}
