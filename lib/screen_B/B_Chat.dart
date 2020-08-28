import 'package:appnewv1/helpers/Constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class B_Chat extends StatefulWidget {
  @override
  _B_ChatState createState() {
    return _B_ChatState();
  }
}

class _B_ChatState extends State<B_Chat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: appBlueColor,
        body: ClipPath(
          clipper: WaveClipperTwo(reverse: true),
          child: Container(
            color: Colors.white,
            child: Column(

                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 1000.0),
                  ),
                  Center(
                    child: Column(children: [
                      Image.asset(
                        'assets/images/icons/pignojob.png',
                        width: double.infinity,
                      ),
                      Text(
                        "Chat",
                        style:
                        TextStyle(color: applightGreyColor, fontSize: 18),
                      )
                    ]),
                  ),
                  new Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                  ),
                ]),
          ),
        ));
  }
}
