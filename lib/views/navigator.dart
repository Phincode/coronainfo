import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class navigator extends StatefulWidget{
  String url;
  navigator(this.url);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _navigator(this.url);
  }



}

class _navigator extends State<navigator>{
  String url;
  _navigator(this.url);
  final flutterWebViewPlugin = FlutterWebviewPlugin();
  bool isloading=false;

  // On urlChanged stream
  StreamSubscription<String> _onUrlChanged;

  // On urlChanged stream
  StreamSubscription<WebViewStateChanged> _onStateChanged;

  StreamSubscription<WebViewHttpError> _onHttpError;

  StreamSubscription<double> _onProgressChanged;

  double progress=0.0;
  @override
  Widget build(BuildContext context) {
    flutterWebViewPlugin.onProgressChanged.listen((double pro) {
      if (mounted) {
        print(pro);
        setState(() {
          progress=pro;
        });
      }
    });

    return new Scaffold(
      body: Stack(
        children: <Widget>[
          new Container(
            margin: EdgeInsets.only(top: 50),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30)),color: Colors.white),
            child: WebviewScaffold(
              bottomNavigationBar: CurvedNavigationBar(
                height: 40,
                backgroundColor: Colors.greenAccent,
                items: <Widget>[
                  Icon(Icons.arrow_back, size: 20),
                  Icon(Icons.refresh, size: 20),
                  Icon(Icons.arrow_back_ios, size: 20),
                  Icon(Icons.arrow_forward_ios, size: 20),
                ],
                onTap: (index) {
                 switch(index){
                   case 0: Navigator.pop(context);
                      break;
                   case 1:flutterWebViewPlugin.reload();
                      break;
                   case 2:
                         flutterWebViewPlugin.goBack();
                    break;
                   case 3:
                         flutterWebViewPlugin.goForward();
                     break;

                 }
                },
              ),
              url:this.url,
              appCacheEnabled: true,

              allowFileURLs: true,
              initialChild: new Center(child: new Text("LOADING...",style: TextStyle(color: Colors.purple),),),
              withZoom: true,
              withLocalUrl: true,
              withJavascript: true,
              supportMultipleWindows: true,
              withLocalStorage: true,
            ),

          ),
          new Container(
            height: MediaQuery.of(context).size.height/9,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(color:Colors.black),
            child: new Center(
              child:  (progress!=1.0)?LinearProgressIndicator(value:progress,backgroundColor:Colors.black,valueColor:AlwaysStoppedAnimation<Color>(Colors.blue),):new Text(""),
            ),
          ),
          
        ],
      )
    );
  }

}