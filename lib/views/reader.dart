import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coronainfo/views/navigator.dart';
import 'package:coronainfo/views/player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'data.dart';


class reader extends StatefulWidget{
  var article;
  reader(this.article);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _reader(this.article);
  }

}
class _reader extends State<reader>{
  var article;

  var isspek=false;
  _reader(this.article);
  int slideIndex=0;
  bool isclickMenu=false;
  var ico=Icon(Icons.dehaze);
  bool voiplus=false;
  FlutterTts flutterTts = FlutterTts();
  final scroocontroller=ScrollController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return new Scaffold(
        backgroundColor: Colors.black,
        body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child:Stack(
              children: <Widget>[
                ListView(
                  controller: scroocontroller,
                  children: <Widget>[
                    CarouselSlider(
                      height: MediaQuery.of(context).size.height/3,
                      viewportFraction: 1.0,
                      aspectRatio: 2.0,
                      autoPlay: false,
                      autoPlayInterval: Duration(seconds: 3),
                      enlargeCenterPage: false,
                      items:slide.map<Widget>((D){
                        return new Builder(
                          builder: (BuildContext context) {
                            return new Stack(
                              children: <Widget>[
                                ClipPath(
                                  clipper:OvalBottomBorderClipper() ,
                                  child: Container(
                                    decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(article["image"]),fit: BoxFit.fill)),
                                  ),
                                ),
                                Positioned(
                                  top: 0,
                                  left: 0,
                                  child: new IconButton(icon: Icon(Icons.arrow_back_ios,color: Colors.black,), onPressed:(){
                                    if(isspek){
                                      flutterTts.stop();
                                    }
                                    Navigator.pop(context);
                                  }),
                                ),
                              ],
                            );
                          },
                        );

                      }).toList(),
                    ),

                    new SizedBox(height: 40,),
                    Wrap(
                      children: <Widget>[
                        new Text(article["titre"],textScaleFactor: 2,style: TextStyle(color: Colors.blue),),
                        (isspek)?new IconButton(icon: Icon(Icons.volume_up,size: 40,color: Colors.red,), onPressed: (){
                          if(isspek){
                            flutterTts.stop();
                            setState(() {
                              isspek=false;
                            });
                          }
                        }):new IconButton(icon: Icon(Icons.volume_off,size: 40,color: Colors.red,), onPressed: () async {
                             await flutterTts.setLanguage("fr-FR");
                             await flutterTts.setSpeechRate(1.0);
                             await flutterTts.setVolume(1.0);
                             await flutterTts.setPitch(1.0);
                            setState(() {
                              isspek=true;
                            });
                            flutterTts.speak(article["article"].toString());
                        })
                      ],
                    ),
                    new SizedBox(height: 10,),
                    new Text(article["article"],style: TextStyle(color: Colors.white),)
                  ],

                ),
              ],
            )





        ));
  }

}