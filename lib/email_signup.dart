import 'package:appnewv1/helpers/helperfunctions.dart';
import 'package:appnewv1/services/database.dart';
import 'helpers/Constants.dart';
import 'package:flutter/material.dart';
import 'services/auth.dart';
import 'package:appnewv1/screen_C/C_MainPage.dart';


const double TextField_title_fontsize = 15;
const double TextField_hint_fontsize = 14;
String errormsg = "sadasdsadas";

TextEditingController _usernameController = TextEditingController();
TextEditingController _emailController = TextEditingController();
TextEditingController _passwordeController = TextEditingController();

clearTextInput() {
  _usernameController.clear();
  _emailController.clear();
  _passwordeController.clear();
}

class C_emailSignup extends StatefulWidget {
  final Function toggle;

  C_emailSignup(this.toggle);

  @override
  _C_emailSignupState createState() {
    return _C_emailSignupState();
  }
}

class _C_emailSignupState extends State<C_emailSignup> {
  void initState() {
    clearTextInput();
    errormsg = '';
  }

  AuthService authService = new AuthService();
  DatabaseMethods databaseMethods = new DatabaseMethods();

  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  signUp() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });

      await authService
          .signUpWithEmailAndPassword(
          _emailController.text.trim().toLowerCase(), _passwordeController.text.trim().toLowerCase())
          .then((result) {
        if (result != null) {
          switch (result) {
            case "ERROR_EMAIL_ALREADY_IN_USE":
              errorMessage = "The email address is already in use by another";
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
              Map<String, String> userDataMap = {
                "name": _usernameController.text.trim().toLowerCase(),
                "email": _emailController.text.trim().toLowerCase(),
              };

              databaseMethods.addUserInfo(userDataMap);

              HelperFunctions.saveUserLoggedInSharedPreference(true);
              HelperFunctions.saveUserNameSharedPreference(
                  _usernameController.text.trim().toLowerCase());
              HelperFunctions.saveUserEmailSharedPreference(
                  _emailController.text.trim().toLowerCase());
              HelperFunctions.saveUserLoggedInEmail(true);
              HelperFunctions.saveUserLoggedInFB(false);
              set_selectedindex3_C();
              Navigator.pushReplacementNamed(context, C_MainPageTag);
          }
        } else {
          setState(() {
            isLoading = false;
          });
        }
      });
    }
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
        //backgroundColor: appBlueColor,
        body: isLoading
            ? Container(
            child: Center(
              child: CircularProgressIndicator(),
            ))
            : SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[_space(),
                            Container(

                              child: Text(errormsg,
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.red)),
                            ),

                            _space(),
                            Container(
                              alignment: Alignment.center,
                              child: Text("Sign Up",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: appDeepBlueColor)),
                            ),
                            //1
                            txtfieldtitle("user name"),
                            textformfield1(_usernameController,
                                "username", 'username is empty'),
                            _space(),
                            //2
                            txtfieldtitle("email"),
                            textformfield2(_emailController, "email",
                                'email is empty'),
                            _space(),

                            //3
                            txtfieldtitle("password"),
                            textformfield3(_passwordeController,
                                "password", 'password is empty'),
                            _space(),
                            Container(
                              alignment: Alignment.centerRight,
                              child: Text("Forgot Password?"),
                            ),
                            //SignUp button
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 16.0),
                              child: RaisedButton(
                                onPressed: () {
                                  // Validate will return true if the form is valid, or false if
                                  // the form is invalid.
                                  if (_formKey.currentState.validate()) {
                                    signUp();
                                  }
                                },
                                child: Text('Signup'),
                              ),
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "Already have account? ",
                                ),
                                new GestureDetector(
                                  onTap: () {
                                    widget.toggle();
                                  },
                                  child: new Text(
                                    "Signin now",
                                    style: TextStyle(
                                        decoration:
                                        TextDecoration.underline),
                                  ),
                                ),
                              ],
                            ),
                          ],
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
        }
        return null;
      },
    );
  }

  Widget textformfield2(TextEditingController textcontroller, String hinttxt,
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
              : "Enter correct email";
        }
        return null;
      },
    );
  }

  Widget textformfield3(TextEditingController textcontroller, String hinttxt,
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
