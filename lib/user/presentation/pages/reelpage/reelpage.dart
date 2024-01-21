import 'dart:developer';

import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:worldhelps/constants/colors.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class ReelScreen extends StatefulWidget {
  const ReelScreen({super.key});

  @override
  State<ReelScreen> createState() => _ReelScreenState();
}

class _ReelScreenState extends State<ReelScreen> {
  PageController pageController = PageController(initialPage: 0);
  VideoPlayerController? controller;
  ChewieController? chewieController;
  int currentPage = 0;

  List<String> videos = [
    'https://www.youtube.com/watch?v=lk2KpcYk_hI',
    'https://www.youtube.com/watch?v=JEK-zP2SFgg',
    'https://www.youtube.com/watch?v=aKQ1Xo2BtuI',
  ];
  late YoutubeExplode yt;

  Future<void> _getVideoStreamUrl(String url) async {
    setState(() {
      controller?.dispose();
    });
    // chewieController?.dispose();

    try {
      final video = await yt.videos.get(url);
      final streamManifest =
          await yt.videos.streamsClient.getManifest(video.id);
      final streamInfo = streamManifest.muxed.withHighestBitrate();
      final streamUrl = streamInfo.url;
      log(streamUrl.toString());

      controller = VideoPlayerController.networkUrl(streamUrl);

      chewieController = ChewieController(
        videoPlayerController: controller!,
        aspectRatio: 10 / 16,
        autoPlay: true,
        looping: false,
        showControls: false,
      );
      setState(() {
        chewieController!.seekTo(Duration.zero);
        chewieController!.play();
      });
    } catch (error) {
      log(error.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    yt = YoutubeExplode();
    _getVideoStreamUrl(videos[0]);
  }

  @override
  void dispose() {
    super.dispose();
    controller!.dispose();
    chewieController!.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text("Shorts"),
        centerTitle: false,
      ),
      body: PageView(
        scrollDirection: Axis.vertical,
        controller: pageController,
        onPageChanged: (value) {
          log('changes');
          chewieController!.pause();
          _getVideoStreamUrl(videos[value]);
        },
        // children: List.generate(
        //   videos.length,
        //   (index) => FutureBuilder(
        //     future: _getVideoStreamUrl(videos[index]),
        //     builder: (context, snapshot) {
        //       return chewieController == null
        //           ? const Center(
        //               child: CupertinoActivityIndicator(color: Colors.white),
        //             )
        //           : Chewie(
        //               controller: chewieController!,
        //             );
        //     },
        //   ),
        // ),

        children: List.generate(
          videos.length,
          (index) => controller == null
              ? const Center(
                  child: CupertinoActivityIndicator(color: Colors.white),
                )
              : Stack(
                  children: [
                    Chewie(
                      controller: chewieController!,
                    ),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: Wrap(
                              direction: Axis.vertical,
                              spacing: 20,
                              children: [
                                Icon(
                                  Icons.favorite_border,
                                  color: primaryWhite,
                                  size: 35,
                                ),
                                Icon(
                                  Icons.comment,
                                  color: primaryWhite,
                                  size: 35,
                                ),
                                Icon(
                                  Icons.send,
                                  color: primaryWhite,
                                  size: 35,
                                ),
                                Icon(
                                  Icons.card_giftcard,
                                  color: primaryWhite,
                                  size: 35,
                                ),
                              ],
                            ),
                          ),
                        )),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            "this is title ",
                            maxLines: 2,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Text(
                            "this is subtitle ",
                            maxLines: 2,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
        ),
      ),
      // body: FutureBuilder(
      //   future: _getVideoStreamUrl(videos[current]),
      //   builder: (context, snapshot) {
      //     return chewieController == null
      //         ? const Center(
      //             child: CupertinoActivityIndicator(color: Colors.white),
      //           )
      //         : Chewie(
      //             controller: chewieController!,
      //           );
      //   },
      // ),
    );
  }
}

// FutureBuilder(
//             future: _getVideoStreamUrl(videos[index]),
//             builder: (context, snapshot) {
//               return chewieController == null
//                   ? const Center(
//                       child: CupertinoActivityIndicator(color: Colors.white),
//                     )
//                   : Chewie(
//                       controller: chewieController!,
//                     );
//             },
//           ),
