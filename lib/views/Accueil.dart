import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coronainfo/views/navigator.dart';
import 'package:coronainfo/views/player.dart';
import 'package:coronainfo/views/reader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'data.dart';

class Accueil extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _Accueil();
  }

}
class _Accueil extends State<Accueil>{
  int slideIndex=0;
  bool isclickMenu=false;
  var ico=Icon(Icons.dehaze);

  bool voiplus=false;

  final scroocontroller=ScrollController();

  var color="red";
  change(){
    if(color=="red"){
      setState(() {
        color="balck";
      });
    }else{
      setState(() {
        color="red";
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer.periodic(Duration(seconds: 1), (_){
      change();
    });
  }


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
                    autoPlay: true,
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
                            decoration: BoxDecoration(image: DecorationImage(image: AssetImage(D["image"]),fit: BoxFit.cover)),
                          ),
                        ),
                        Center(
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            color:Colors.black38,
                            child: new Text(D["titre"],style: TextStyle(color: D["couleur"]),textAlign: TextAlign.center,),
                          ),
                        ),

                      ],
                    );
                    },
                   );

                }).toList(),
            ),
                      new SizedBox(height: 30,),

                      new Wrap(
                        alignment: WrapAlignment.center,
                        children: <Widget>[
                          SizedBox(width:10,),
                          new RaisedButton(color:(color=="red")? Colors.red:Colors.blue,onPressed: (){
                            Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context){
                              return new navigator("https://www.maladiecoronavirus.fr/se-tester");
                            }));
                            },child: new Text("Se diagnostiquer",style: TextStyle(color:(color=="red")?Colors.black:Colors.white),),),

                        ],
                      ),

                    new SizedBox(height: 40,),
                     new Text("Sensibilisation en langue",textAlign: TextAlign.center,textScaleFactor: 2,style: TextStyle(color: Colors.blue),),
                      new SizedBox(height: 10,),
                      Container(
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        child: new ListView.builder(scrollDirection: Axis.horizontal,itemCount: vid.length,itemBuilder: (BuildContext context,index){
                          return new Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                            GestureDetector(
                              onTap: (){
                                Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context){
                                  return new player(vid[index]);
                                }));
                              },
                              child: new Stack(
                                children: <Widget>[
                                  Container(
                                    height: 170,
                                    width:  170,
                                    margin: EdgeInsets.only(right: 10,left: 15),
                                    decoration: BoxDecoration(shape: BoxShape.rectangle,border: Border.all(color: Colors.blue),image: DecorationImage(image: AssetImage(vid[index]["image"]),fit: BoxFit.cover)),
                                    child: new Center(child:Icon(Icons.play_circle_outline,color: Colors.blue,size: 50,) )
                                  ),

                                ],
                              ),
                            ),
                            new Text(vid[index]["langue"],textScaleFactor: 1.3,style: TextStyle(color: Colors.red),)
                            ],
                          );

                        }),

                      ),
                      new Text("Infos de dernières minutes",textScaleFactor: 2,textAlign: TextAlign.center,style: TextStyle(color: Colors.blue),),
                      new Text(" ''Toucher un article pour le lire'' ",textAlign: TextAlign.center,style: TextStyle(color: Colors.white),),
                      new SizedBox(height: 10,),
                      Container(
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        child: StreamBuilder(
                          stream: Firestore.instance.collection("news").orderBy('created',descending: true).snapshots(),
                          builder:(BuildContext context,snapshot){
                            if(snapshot.hasData){
                              return ListView.builder(scrollDirection: Axis.horizontal,itemCount: snapshot.data.documents.length,itemBuilder: (BuildContext context,index){
                                return new Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: (){
                                        Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context){
                                          return new reader(snapshot.data.documents[index]);
                                        }));
                                      },
                                      child: new Stack(
                                        children: <Widget>[
                                          Container(
                                              height: 170,
                                              width:  170,
                                              margin: EdgeInsets.only(right: 10,left: 9),
                                              decoration: BoxDecoration(shape: BoxShape.rectangle,border: Border.all(color: Colors.blue),image: DecorationImage(image: NetworkImage(snapshot.data.documents[index]["image"]),fit: BoxFit.cover)),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: <Widget>[
                                                new Container(
                                                  height: 50,
                                                  width: 180,
                                                  color: Colors.black54,
                                                  child: new Center(
                                                    child: new Text(snapshot.data.documents[index]["article"],overflow: TextOverflow.ellipsis,style: TextStyle(color: Colors.white),textAlign: TextAlign.center,),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),


                                        ],
                                      ),
                                    ),
                                    new Text(snapshot.data.documents[index]["titre"],overflow:TextOverflow.fade,textScaleFactor: 1.2,style: TextStyle(color: Colors.red),)
                                  ],
                                );

                              });
                            }
                            return new Center(child: new Text("Loading...",style: TextStyle(color: Colors.red),),);
                          },
                        ),

                      ),
                    ],


                  ),


              ],
            )





        ));
  }

}