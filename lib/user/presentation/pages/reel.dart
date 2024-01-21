// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class ShortVideoScreen extends StatefulWidget {
  ShortVideoScreen(
      {Key? key,
      required this.url,
      required this.controller,
      required this.chewieController})
      : super(key: key);
  final String url;

  VideoPlayerController? controller;
  ChewieController? chewieController;
  @override
  State<ShortVideoScreen> createState() => _ShortVideoScreenState();
}

class _ShortVideoScreenState extends State<ShortVideoScreen> {
  late YoutubeExplode yt;

  String url = '';

  @override
  void initState() {
    super.initState();
    yt = YoutubeExplode();
    _getVideoStreamUrl();
  }

  Future<void> _getVideoStreamUrl() async {
    try {
      // final video = await yt.videos.get('https://www.youtube.com/watch?v=C_dNt4UEVZQ');
      final video = await yt.videos.get(widget.url);
      final streamManifest =
          await yt.videos.streamsClient.getManifest(video.id);
      final streamInfo = streamManifest.muxed.withHighestBitrate();
      final streamUrl = streamInfo.url;
      log(streamUrl.toString());
      // setState(() {
      //   url = streamUrl.toString();
      // });
      widget.controller = VideoPlayerController.networkUrl(streamUrl);

      widget.chewieController = ChewieController(
          videoPlayerController: widget.controller!,
          aspectRatio: 16 / 30, // Adjust as needed
          autoPlay: true,
          looping: false,
          showControls: false
          // Additional customization options
          );
    } catch (error) {
      // Handle errors appropriately
      log(error.toString());
    }
  }

  // @override
  // void dispose() {
  //   super.dispose();
  //   chewieController!.dispose();
  //   controller!.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: FutureBuilder(
        future: _getVideoStreamUrl(),
        builder: (context, snapshot) {
          return widget.controller == null
              ? const Center(
                  child: CupertinoActivityIndicator(),
                )
              : Chewie(
                  controller: widget.chewieController!,
                );
        },
      ),
    );
  }
}
