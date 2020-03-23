import 'package:coronainfo/views/Accueil.dart';
import 'package:coronainfo/views/splashscreen.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CoronaInfos',
      theme: ThemeData(
        fontFamily: 'Avenir',
      ),
      home: splash(),
    );
  }
}
