import 'package:appnewv1/helpers/Constants.dart';
import 'package:flutter/material.dart';

class Justforfun extends StatefulWidget {
  @override
  _JustforfunState createState() {
    return _JustforfunState();
  }
}

class _JustforfunState extends State<Justforfun> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildBar(context),
      backgroundColor: appWhiteColor,
      body:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment:   CrossAxisAlignment.center,


          children:<Widget>[
            new Padding(
              padding: const EdgeInsets.symmetric(horizontal: 1000.0),
            ),
            Text ("不知道就過主吧",style: TextStyle(fontSize: 20.0,
                height: 1.5,color: appDeepBlueColor, fontWeight: FontWeight.bold
            )),
            new Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
            ),
            _btn_1(context),



          ]
      ),

      resizeToAvoidBottomPadding: false,
    );
  }

  Widget _buildBar(BuildContext context) {
    return new AppBar(
      elevation: 0.1,
      backgroundColor: appBlueColor,
      /*leading: new IconButton(
            icon: _searchIcon
        )*/
    );
  }
  Widget _btn_1(BuildContext context) {
    return new ButtonTheme(
        minWidth: 200.0,
        height: 40.0,
        shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
        child: RaisedButton(
          onPressed: (){
            Navigator.pop(context);
          },
          child: Text('鵝是沒銀兩的老細',style: TextStyle(fontSize: 18.0,
              color: appDeepBlueColor)),
          color:appBlueColor,
        )
    );
  }
}
