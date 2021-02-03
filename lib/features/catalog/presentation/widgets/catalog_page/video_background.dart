import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lusy_in_the_sky/core/image/cached_image.dart';
import 'package:video_player/video_player.dart';

class VideoBackground extends StatefulWidget {
  final String _video;
  final String _image;

  const VideoBackground({
    Key key,
    @required String video,
    @required String image,
  })  : _video = video,
        _image = image,
        super(key: key);

  @override
  _VideoBackgroundState createState() => _VideoBackgroundState();
}

class _VideoBackgroundState extends State<VideoBackground> {
  Future<void> _initializeVideoPlayerFuture;
  VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
      widget._video,
    )..setLooping(true);
    _initializeVideoPlayerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(375),
      height: ScreenUtil().setHeight(667),
      child: FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            _controller.play();
            return FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                height: _controller.value.size?.height ?? 0,
                width: _controller.value.size?.width ?? 0,
                child: VideoPlayer(_controller),
              ),
            );
          } else {
            return FutureBuilder(
              future: CachedImage.get(url: widget._image),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if(snapshot.hasData){
                  return Image.file(
                    snapshot.data,
                    fit: BoxFit.cover,
                  );
                } else {
                  return Image.network(
                    widget._image,
                    fit: BoxFit.cover,
                  );
                }
              },
            );
          }
        },
      ),
    );
  }
}
