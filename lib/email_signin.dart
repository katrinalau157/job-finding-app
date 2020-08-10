import 'package:appnewv1/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'helpers/Constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'helpers/helperfunctions.dart';
import 'package:appnewv1/services/auth.dart';
import 'package:appnewv1/screen_C/C_MainPage.dart';

const double TextField_title_fontsize = 15;
const double TextField_hint_fontsize = 14;

TextEditingController _emailController = TextEditingController();
TextEditingController _passwordeController = TextEditingController();
String errormsg = "";

clearTextInput() {
  _emailController.clear();
  _passwordeController.clear();
}

class C_emailSignin extends StatefulWidget {
  final Function toggle;
  C_emailSignin(this.toggle);

  @override
  _C_emailSigninState createState() {
    return _C_emailSigninState();
  }
}

class _C_emailSigninState extends State<C_emailSignin> {
  final _formKey = GlobalKey<FormState>();

  AuthService authService = new AuthService();

  bool isLoading = false;
  QuerySnapshot snapshotUserInfo;

  signIn() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });

      await authService
          .signInWithEmailAndPassword(
          _emailController.text.trim().toLowerCase(), _passwordeController.text.trim().toLowerCase())
          .then((result) async {
        if (result != null)  {
          print(result);
          switch (result) {
            case "ERROR_INVALID_EMAIL":
              errorMessage = "Your email address appears to be malformed.";
              setState(() {
                errormsg = errorMessage;
                isLoading = false;
              });
              break;
            case "ERROR_WRONG_PASSWORD":
              errorMessage = "Your password is wrong.";
              setState(() {
                errormsg = errorMessage;
                isLoading = false;
              });
              break;
            case "ERROR_USER_NOT_FOUND":
              errorMessage = "User with this email doesn't exist.";
              setState(() {
                errormsg = errorMessage;
                isLoading = false;
              });
              break;
            case "ERROR_USER_DISABLED":
              errorMessage = "User with this email has been disabled.";
              setState(() {
                errormsg = errorMessage;
                isLoading = false;
              });
              break;
            case "ERROR_TOO_MANY_REQUESTS":
              errorMessage = "Too many requests. Try again later.";
              setState(() {
                errormsg = errorMessage;
                isLoading = false;
              });
              break;
            case "ERROR_OPERATION_NOT_ALLOWED":
              errorMessage =
              "Signing in with Email and Password is not enabled.";
              setState(() {
                errormsg = errorMessage;
                isLoading = false;
              });
              break;
            default:
            //
/*              String email = _emailController.text.toString();
             QuerySnapshot userInfoSnapshot =
             await DatabaseMethods().getUserInfo(email);
            //print(userInfoSnapshot.documents[0].data["name"]);
              HelperFunctions.saveUserLoggedInSharedPreference(true);
              HelperFunctions.saveUserEmailSharedPreference(email);
              print(result.userId);
              print("result.userId");
              print("result.userId");
              final snapshot = await Firestore.instance.collection('users').where("email", isEqualTo: "123@123.com")
                  .getDocuments();

              print(snapshot.documents);

              print("result.userId");*/
              print(result);

              String email = _emailController.text.trim().toString().toLowerCase();
              QuerySnapshot userInfoSnapshot =
              await DatabaseMethods().getUserInfo(email);

              HelperFunctions.saveUserLoggedInSharedPreference(true);
              HelperFunctions.saveUserNameSharedPreference(
                  userInfoSnapshot.documents[0].data["name"]);

              HelperFunctions.saveUserEmailSharedPreference(
                  userInfoSnapshot.documents[0].data["email"]);


              HelperFunctions.saveUserLoggedInEmail(true);
              HelperFunctions.saveUserLoggedInFB(false);
              //

              set_selectedindex3_C();
              Navigator.pushReplacementNamed(context, C_MainPageTag);

          }

          /*QuerySnapshot userInfoSnapshot =
          await DatabaseMethods().getUserInfo(_emailController.text);
        print(userInfoSnapshot);
          print('userInfoSnapshot');
         HelperFunctions.saveUserLoggedInSharedPreference(true);
          HelperFunctions.saveUserNameSharedPreference(
              userInfoSnapshot.documents[0].data["name"]);
          HelperFunctions.saveUserEmailSharedPreference(
              userInfoSnapshot.documents[0].data["email"]);*//*

          set_selectedindex3_C();
          Navigator.pushReplacementNamed(context, C_MainPageTag);*/
        } else {
          setState(() {
            isLoading = false;
          });
        }
      });
    }
  }

  void initState() {
    errormsg = '';
    clearTextInput();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text('email'),
          elevation: 0.0,
          backgroundColor: appBlueColor,
        ),
        backgroundColor: appBlueColor,
        body: isLoading
            ? Container(
          child: Center(child: CircularProgressIndicator()),
        )
            : ClipPath(
          clipper: WaveClipperTwo(reverse: true),
          child: Container(
            color: Colors.white,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: SingleChildScrollView(
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                child: Text(errormsg,
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.red)),
                              ),
                              _space(),
                              Container(
                                alignment: Alignment.center,
                                child: Text("Sign In",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: appDeepBlueColor)),
                              ),
                              _space(),

                              //1
                              txtfieldtitle("email"),
                              textformfield1(_emailController, "email",
                                  'Please enter some text'),
                              _space(),

                              //2
                              txtfieldtitle("password"),
                              textformfield2(_passwordeController,
                                  "password", 'Please enter some text'),
                              _space(),
                              Container(
                                alignment: Alignment.centerRight,
                                child: Text("Forgot Password?"),
                              ),

                              //signin button
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 16.0),
                                child: RaisedButton(
                                  onPressed: () {
                                    // Validate will return true if the form is valid, or false if
                                    // the form is invalid.
                                    if (_formKey.currentState
                                        .validate()) {
                                      signIn();
                                    }
                                  },
                                  child: Text('Signin'),
                                ),
                              ),

                              //Don't have account?
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    "Don't have account? ",
                                  ),
                                  new GestureDetector(
                                    onTap: () {
                                      widget.toggle();
                                    },
                                    child: new Text(
                                      "Register now",
                                      style: TextStyle(
                                          decoration:
                                          TextDecoration.underline),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ))
                ]),
          ),
        ));
  }

  Widget textformfield1(TextEditingController textcontroller, String hinttxt,
      String validator_str) {
    return TextFormField(
      controller: textcontroller,
      decoration: InputDecoration(
        hintText: hinttxt,
        hintStyle: TextStyle(fontSize: TextField_hint_fontsize),
        contentPadding: EdgeInsets.all(6),
        isDense: true,
        focusedBorder: UnderlineInputBorder(
          borderSide: const BorderSide(color: Colors.blueGrey),
        ),
      ),
      validator: (value) {
        if (value.isEmpty) {
          return validator_str;
        } else {
          return RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
              .hasMatch(value)
              ? null
              : "Please Enter Correct Email";
        }
      },
    );
  }

  Widget textformfield2(TextEditingController textcontroller, String hinttxt,
      String validator_str) {
    return TextFormField(
      obscureText: true,
      controller: textcontroller,
      decoration: InputDecoration(
        hintText: hinttxt,
        hintStyle: TextStyle(fontSize: TextField_hint_fontsize),
        contentPadding: EdgeInsets.all(6),
        isDense: true,
        focusedBorder: UnderlineInputBorder(
          borderSide: const BorderSide(color: Colors.blueGrey),
        ),
      ),
      validator: (value) {
        if (value.isEmpty) {
          return validator_str;
        } else {
          return value.length < 6 ? "Enter Password 6+ characters" : null;
        }
      },
    );
  }

  Widget txtfieldtitle(String titlename) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        child: Text(titlename,
            style: TextStyle(
              color: appGreenBlueColor,
              fontSize:
              TextField_title_fontsize, //You can set your custom height here
            )),
      ),
    );
  }

  Widget _space() {
    return new Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
    );
  }
}
