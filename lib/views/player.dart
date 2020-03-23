import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';


class player extends StatefulWidget{
  var data;
  player(this.data);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _player(this.data);
  }

}

class _player extends State<player>{
  var data;
  VideoPlayerController _controller;

  bool istouch=false;
  bool isplaying=true;
  _player(this.data);



  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(
        data["video"])
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
    _controller.play();
  }


  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.black,
      body: new Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: new Stack(
          children: <Widget>[
            Positioned(
              top: 40,
              left: 1,
              child: new IconButton(icon: Icon(Icons.arrow_back_ios,color: Colors.red,), onPressed: (){
                     Navigator.pop(context);
              }),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                _controller.value.initialized
                    ? AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: GestureDetector(
                    onTap: (){
                      if(istouch){
                        setState(() {
                          istouch=false;
                        });
                      }else{
                        setState(() {
                          istouch=true;
                        });
                      }

                    },
                    child: Stack(
                      children: <Widget>[
                        VideoPlayer(_controller),
                        Center(
                          child: new Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              (istouch)?(isplaying) ? new IconButton(icon: Icon((Icons.pause),size: 40,), onPressed: (){
                                     _controller.pause();
                                     setState(() {
                                       isplaying=false;
                                     });
                              }): new IconButton(icon: Icon((Icons.play_arrow),size: 40,), onPressed: (){
                                _controller.play();
                                setState(() {
                                  isplaying=true;
                                });
                              }):new Text("")
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                )
                    : Container(),
                SizedBox(height: 20,),

                Text(data["titre"],style: TextStyle(color: Colors.blue),textAlign: TextAlign.center,)


              ],
            )



          ],
        ),
      ),
    );
  }

}