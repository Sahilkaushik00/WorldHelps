import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ReelPage extends StatefulWidget {
  final List<String> videoUrls;

  const ReelPage({super.key, required this.videoUrls});

  @override
  State<ReelPage> createState() => _ReelPageState();
}

class _ReelPageState extends State<ReelPage> {
  late PageController _pageController;
  late VideoPlayerController _videoPlayerController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _initializeVideoPlayer();
  }

  void _initializeVideoPlayer() {
    _videoPlayerController = VideoPlayerController.networkUrl(
      Uri.parse(widget.videoUrls[_currentPage]),
    )..initialize().then((_) {
        setState(() {});
      });

    _videoPlayerController.addListener(() {
      if (!_videoPlayerController.value.isPlaying &&
          _videoPlayerController.value.isInitialized) {
        if (_pageController.page == widget.videoUrls.length - 1) {
          // End of the list, you may want to loop or navigate back to the first video.
          // For simplicity, we'll just restart the video.
          _videoPlayerController.seekTo(Duration.zero);
          _videoPlayerController.play();
        } else {
          // Move to the next video in the list.
          _pageController.nextPage(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut);
        }
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reel Page'),
      ),
      body: PageView.builder(
        controller: _pageController,
        itemCount: widget.videoUrls.length,
        onPageChanged: (int page) {
          setState(() {
            _currentPage = page;
            _videoPlayerController.pause();
            _videoPlayerController = VideoPlayerController.networkUrl(
              Uri.parse(widget.videoUrls[_currentPage]),
            )..initialize().then((_) {
                _videoPlayerController.play();
                setState(() {});
              });
          });
        },
        itemBuilder: (context, index) {
          return Center(
            child: _videoPlayerController.value.isInitialized
                ? AspectRatio(
                    aspectRatio: _videoPlayerController.value.aspectRatio,
                    child: VideoPlayer(_videoPlayerController),
                  )
                : const CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
