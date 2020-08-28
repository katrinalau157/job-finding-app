import 'package:appnewv1/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:database_adapter_postgre/database_adapter_postgre.dart';
import 'helpers/Constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'helpers/helperfunctions.dart';
import 'package:appnewv1/services/auth.dart';
import 'package:appnewv1/screen_C/C_MainPage.dart';
import 'package:appnewv1/helpers/loading.dart';

TextEditingController problem_disController = TextEditingController();
TextEditingController emailController = TextEditingController();

_clearTextInput() {
  problem_disController.clear();
  emailController.clear();
}

const double TextField_title_fontsize = 12;
const double TextField_hint_fontsize = 11;

class problem_page extends StatefulWidget {
  @override
  _problem_pageState createState() => _problem_pageState();
}

class _problem_pageState extends State<problem_page> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text('問題回報與申報'),
          elevation: 0.0,
          backgroundColor: appBlueColor,
        ),
        backgroundColor: appWhiteColor,
        body: body_container());
  }

  Widget txtfieldtitle(String titlename) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        child: Text(titlename,
            style: TextStyle(
              color: appBlackColor,
              fontSize:
                  TextField_title_fontsize, //You can set your custom height here
            )),
      ),
    );
  }

  String dropdownValue = 'Bug 回報';

  Widget dropdown() {
    return DropdownButton<String>(
        value: dropdownValue,
        isExpanded: true,
        hint: Text("選擇問題類型"),
        onChanged: (String newValue) {
          setState(() {
            dropdownValue = newValue;
            print(dropdownValue);
          });
        },
        items: <String>[
          'Bug 回報',
          '優化建議',
          '檢舉相關',
          '履歷相關',
          '公司資料相關',
          '職缺相關',
          '其他'
        ].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: TextStyle(fontSize: TextField_hint_fontsize),
            ),
          );
        }).toList());
  }

  //user type

  Widget textformfield_multi(TextEditingController textcontroller,
      String hinttxt, String validator_str) {
    return TextFormField(
      style: TextStyle(fontSize: TextField_hint_fontsize),
      keyboardType: TextInputType.multiline,
      maxLines: null,
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
  Widget _space() {
    return new Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
    );
  }

  //email
  Widget textformfield1(TextEditingController textcontroller, String hinttxt,
      String validator_str) {
    return TextFormField(
      style: TextStyle(fontSize: TextField_hint_fontsize),
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
  void initState() {
    _clearTextInput();
  }
  Future start(String a) async {
    String sqlquery = a;
    final database = Postgre(
      host: '10.0.2.2',
      port: 5432,
      user: 'postgres',
      password: 'ocg123',
      databaseName: 'appdb',
    ).database();

    await database.sqlClient.query(sqlquery).getIterator();
  }
  Widget body_container() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
/*            mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,*/
                children: [
                  Text(
                    "請描述你所遇到的問題，我們將不斷改善，以提供優質的服務給你。",
                    style: TextStyle(fontSize: 13),
                  ),
                  _space(),
                  _space(),
                  _space(),
                  _space(),
                  _space(),
                  txtfieldtitle("問題類型"),
                  dropdown(),
                  _space(),
                  //3
                  txtfieldtitle("問題描述"),
                  textformfield_multi(
                      problem_disController, "問題描述", 'Please enter some text'),
                  _space(),
                  _space(),

                  txtfieldtitle("E-mail"),
                  textformfield1(emailController, "e.g. abc@abc.com",
                      'Please enter some text'),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: RaisedButton(
                      onPressed: () {
                        if (_formKey.currentState.validate()) {

                          print(dropdownValue);
                          print(problem_disController.text.trim());
                          print(emailController.text.trim());
                          String text_problem = problem_disController.text.trim();
                          String text_email = emailController.text.trim();

                          String sqlquery =
                              "INSERT INTO report(email, report_type, report_detail)VALUES('$text_email','$text_problem','$dropdownValue')";
                          start(sqlquery);
                          print(sqlquery);
                          _formKey.currentState.reset();
                          _clearTextInput();
                          Navigator.pop(context);
                        }
                      },
                      child: Text('sent'),
                    ),
                  ),
                ]),
          ),
        ),
      ),
    );
  }

}
