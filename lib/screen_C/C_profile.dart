import 'package:flutter/material.dart';
import 'package:appnewv1/helpers/Constants.dart';

const double TextField_title_fontsize = 15;
const double TextField_hint_fontsize = 14;

TextEditingController _c_nameController = TextEditingController();
TextEditingController _c_birthController = TextEditingController();
TextEditingController _c_residenceController = TextEditingController();

TextEditingController _c_emailController = TextEditingController();
TextEditingController _c_phoneNoController = TextEditingController();
TextEditingController _c_schoolNameController = TextEditingController();
TextEditingController _c_MajorController = TextEditingController();

int selectedindex;

clearTextInput() {
  _c_nameController.clear();
  _c_birthController.clear();
  _c_residenceController.clear();
  _c_emailController.clear();
  _c_phoneNoController.clear();
  _c_schoolNameController.clear();
  _c_MajorController.clear();
}



class C_profile extends StatefulWidget {
  C_profile({Key key}) : super(key: key);
  @override
  _C_profileState createState() => _C_profileState();
}

class _C_profileState extends State<C_profile> {
  final _formKey = GlobalKey<FormState>();

  Widget textformfield(TextEditingController textcontroller, String hinttxt,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            elevation: 0.1,
            backgroundColor: appBlueColor,
            title: Text(
              "刊登職缺",
              style: TextStyle(fontSize: 20.0, color: appDeepBlueColor),
            )),
        body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(
                      child: Image.asset(
                        'assets/images/icons/profile_icon.png',
                        width: MediaQuery.of(context).size.width / 2,
                      ),
                    ),
                    //1
                    txtfieldtitle("姓名"),
                    textformfield(_c_nameController, "陳小豬",
                        'Please enter some text'),
                    _space(),
                    //2
                    txtfieldtitle("生日"),
                    textformfield(_c_birthController, "請選擇生日",
                        'Please enter some text'),
                    _space(),
                    //3
                    txtfieldtitle("居住地"),
                    textformfield(_c_residenceController, "請選擇地區",
                        'Please enter some text'),
                    _space(),
                    //4
                    txtfieldtitle("E-mail"),
                    textformfield(
                        _c_emailController, "alldayworkworkpig@earnmoney.com", 'Please enter some text'),
                    _space(),

                    //5
                    txtfieldtitle("手機"),
                    textformfield(
                        _c_phoneNoController, "21800000", 'Please enter some text'),
                    _space(),

                    //6
                    txtfieldtitle("學校名稱"),
                    textformfield(_c_schoolNameController, "輸入學校關鍵字找找看",
                        'Please enter some text'),
                    _space(),

                    //7
                    txtfieldtitle("科系名稱"),
                    textformfield(
                        _c_MajorController, "輸入科系關鍵字找找看", 'Please enter some text'),
                    _space(),
                    _space(),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: RaisedButton(
                        onPressed: () {
                          // Validate will return true if the form is valid, or false if
                          // the form is invalid.
                          if (_formKey.currentState.validate()) {
                            //_formKey.currentState.save();
                            print(_c_nameController.text);
                            print(_c_birthController.text);
                            print(_c_residenceController.text);
                            print(_c_emailController.text);
                            print(_c_phoneNoController.text);
                            print(_c_schoolNameController.text);
                            print(_c_MajorController.text);
                            _formKey.currentState.reset();
                            clearTextInput();
                            Navigator.pop(context);
                          }
                        },
                        child: Text('Submit'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: RaisedButton(
                        onPressed: () {
                          _formKey.currentState.reset();
                          clearTextInput();
                        },
                        child: Text('reset'),
                      ),
                    ),
                  ],
                ),
              ),
            )));
  }
}
