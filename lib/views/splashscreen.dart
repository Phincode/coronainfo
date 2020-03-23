
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

import 'Accueil.dart';

class splash extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _splash();
  }


}

class _splash extends State<splash>{
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
      seconds: 3,
      navigateAfterSeconds: Accueil(),
      title: new Text('CoronaInfos',
        style: new TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0
        ),
      ),
      image: new Image.asset("assets/image/logo.png",),
      gradientBackground: new LinearGradient(colors: [ Colors.black,Colors.blue], begin: Alignment.topLeft, end: Alignment.bottomRight),
      backgroundColor: Colors.white,
      styleTextUnderTheLoader: new TextStyle(),
      photoSize: 100.0,
      onClick: ()=>print("pressing"),
      loaderColor: Colors.blue,
    );
  }

}