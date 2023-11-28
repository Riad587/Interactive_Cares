import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';

import 'dashboard.dart';
import 'model/video_model.dart';

class VideoTutorial extends StatefulWidget{

  @override
  State<VideoTutorial> createState() => _State();
}

class _State extends State<VideoTutorial> {


  static const snackBar = SnackBar(
    content: Text('No data found!'),
  );

    VideoPlayerController? _controller;
  int _currentIndex=0;

  void _playVideo({int index=0,bool init = false}){

    if(index < 0 || index > list.length) return;
    if(!init){
      _controller?.pause();
    }
    setState(() {
      _currentIndex=index;
    });
    _controller = VideoPlayerController.networkUrl(Uri.parse(list[index].url.toString()))
    ..addListener(() => setState(() {}))
    ..setLooping(true)
    ..initialize().then((value) => _controller?.play());
  }


  @override
  void initState() {
    super.initState();
    videoInitialized();
    _playVideo(init: false);
  }

  @override
  void dispos(){
    _controller?.dispose();
    super.dispose();
  }
  List<VideoModel> list=[

    VideoModel(
      name: "Bug Bug Bunny",
      url: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
      thumbnail: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/BigBuckBunny.jpg",
    ),
    VideoModel(
      name: "Elephant Dream",
      url: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
      thumbnail: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/ElephantsDream.jpg",
    ),
    VideoModel(
      name: "Bug Bug Bunny",
      url: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4",
      thumbnail: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/ForBiggerBlazes.jpg",
    ),
    VideoModel(
      name: "For Bigger Blazes",
      url: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
      thumbnail: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/BigBuckBunny.jpg",
    ),
    VideoModel(
      name: "For Bigger Escape",
      url: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4" ,
      thumbnail: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/ForBiggerEscapes.jpg" ,
    ),

    VideoModel(
      name: "For Bigger Escape",
      url: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4" ,
      thumbnail: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/ForBiggerEscapes.jpg" ,
    ),

    VideoModel(
      name: "For Bigger Blazes",
      url: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
      thumbnail: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/BigBuckBunny.jpg",
    ),
    VideoModel(
      name: "For Bigger Escape",
      url: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4" ,
      thumbnail: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/ForBiggerEscapes.jpg" ,
    ),
    VideoModel(
      name: "Bug Bug Bunny",
      url: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
      thumbnail: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/BigBuckBunny.jpg",
    ),
    VideoModel(
      name: "Elephant Dream",
      url: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
      thumbnail: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/ElephantsDream.jpg",
    ),
  ];

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
        onWillPop: () async {
          _controller!.pause();
          return true;
        },
        child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [

              Container(
                height: 400.h,
                color: Colors.orangeAccent,
                child: _controller!.value.isInitialized?
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 300.h,
                      child: VideoPlayer(_controller!),
                    ),

                    SizedBox(
                      height: 15.h,
                      child:   VideoProgressIndicator(
                        _controller!,
                        allowScrubbing: true,

                      ),
                    ),
                    IconButton(onPressed: ()=> _controller!.value.isPlaying?
                    _controller!.pause():_controller!.play(),
                        icon: Icon(
                          _controller!.value.isPlaying?Icons.pause:Icons.play_arrow,
                          color: Colors.white,
                          size: 50.sp,
                        ),
                    )
                  ],
                ): Center(
                  child: CircularProgressIndicator(color: Colors.white,),
                )
              ),
              Expanded(
                  child: ListView.builder(
                     itemCount: list.length,
                    itemBuilder: (context, int index){

                       return InkWell(
                         onTap: (){ _playVideo(index: index);},
                         child: Padding(
                             padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10.h),

                           child: Row(
                             children: [
                               SizedBox(
                                 height: 100.h,
                                 width: 100.w,
                                 child: Image.network(list[index].thumbnail.toString(),fit: BoxFit.contain,),
                               ),
                               SizedBox(width: 10.w,),
                               Text(list[index].name.toString(),style: TextStyle(fontSize: 20.sp,color: Colors.black54),),
                             ],
                           ),
                         ),
                       );
                    },
                  ),
              ),
            ],
          ),
        )
        )
    );
  }

  void videoInitialized() {

  }

}

