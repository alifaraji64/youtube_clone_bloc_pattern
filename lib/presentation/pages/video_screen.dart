import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

class VideoScreenArguments {
  final String videoUrl;
  const VideoScreenArguments(this.videoUrl);
}

class VideoScreen extends StatefulWidget {
  const VideoScreen({Key key}) : super(key: key);

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  ChewieController _chewieController;

  @override
  Widget build(BuildContext context) {
    final VideoScreenArguments args = ModalRoute.of(context).settings.arguments;
    _chewieController = ChewieController(
      videoPlayerController: VideoPlayerController.network(
        args.videoUrl,
      ),
      autoInitialize: true,
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Text(
            errorMessage,
            style: TextStyle(color: Colors.red),
          ),
        );
      },
    );
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Chewie(
          controller: _chewieController,
        ),
        //child: GestureDetector(onTap: () {}, child: Text(args.videoUrl)),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _chewieController.dispose();
  }
}
