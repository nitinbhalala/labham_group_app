// ignore_for_file: avoid_single_cascade_in_expression_statements, must_be_immutable
import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:flutter/material.dart';
import 'dart:core';
import 'package:minimall_store/views/comman/loader.dart';

class ViewVideo extends StatefulWidget {
  final String videoUrl;

  const ViewVideo({Key? key, required this.videoUrl}) : super(key: key);

  @override
  State<ViewVideo> createState() => _ViewVideoState();
}

class _ViewVideoState extends State<ViewVideo> {
  late VideoPlayerController videoPlayerController;
  late CustomVideoPlayerController _customVideoPlayerController;
  bool _isVideoInitialized = false;
  bool _isDisposed = false;

 @override
  void initState() {
    super.initState();
    videoPlayerController = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((value) {
        if (!_isDisposed) {
          videoPlayerController.play();
          videoPlayerController.setLooping(true);
          setState(() {
            _isVideoInitialized = true;
          });
        }
      });
    _customVideoPlayerController = CustomVideoPlayerController(
      context: context,
      videoPlayerController: videoPlayerController,
    );
  }



  @override
  void dispose() {
    if (!_isDisposed) {
      _customVideoPlayerController.dispose();
      videoPlayerController.dispose();
      _isDisposed = true;
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _isVideoInitialized
            ? SizedBox(
                height: double.infinity,
                child: CustomVideoPlayer(
                  customVideoPlayerController: _customVideoPlayerController,
                ),
              )
            : Loader(),
      ),
    );
  }
}
