import 'package:flutter/material.dart';

class loadingPig extends StatefulWidget {
  @override
  _loadingPigState createState() => _loadingPigState();
}
Animation<double> animation;
AnimationController controller;
class _loadingPigState extends State<loadingPig> with SingleTickerProviderStateMixin{
  @override

  Tween tween = new Tween<double>(begin: 0.0, end: 0.1);

  Widget build(BuildContext context) {
    return new Center(
        child: new RotationTransition(
            turns: controller,
            child: new Image.asset(
              'assets/images/icons/pngwave.png',
              width: MediaQuery.of(context).size.width / 5,
            )
        )
    );
  }

  void initState() {
    super.initState();
    controller = new AnimationController(vsync: this,
        duration: new Duration(seconds: 8));
    controller.repeat();
    // More code here
  }
  @override
  dispose() {
    controller.dispose(); // you need this
    super.dispose();
  }
}
