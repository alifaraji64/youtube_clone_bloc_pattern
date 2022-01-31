import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chewie/chewie.dart';
import 'package:youtube_clone/presentation/cubits/profile_avatar_picker_cubit.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({Key key}) : super(key: key);

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  ChewieController _chewieController;
  @override
  void initState() {
    super.initState();
    // _chewieController = ChewieController(
    //   videoPlayerController: VideoPlayerController.network(
    //       'https://firebasestorage.googleapis.com/v0/b/pizzato-1bd98.appspot.com/o/New%20Tab%20-%20Brave%202021-04-17%2021-02-22.mp4?alt=media&token=d78adb55-e27c-4643-a87e-f51e52d60fde'),
    //   autoInitialize: true,
    //   errorBuilder: (context, errorMessage) {
    //     return Center(
    //       child: Text(
    //         errorMessage,
    //         style: TextStyle(color: Colors.red),
    //       ),
    //     );
    //   },
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        // child: Chewie(
        //   controller: _chewieController,
        // ),
        child: GestureDetector(
            onTap: () {}, child: Text('logjdhfkghdklfghdkjfghdhfghdfkj')),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    //_chewieController.dispose();
  }
}
