import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_clone/presentation/cubits/delete_video_cubit.dart';
import 'package:youtube_clone/presentation/cubits/get_videos_cubit.dart';
import 'package:youtube_clone/presentation/pages/video_screen.dart';

class VideoGrid extends StatelessWidget {
  const VideoGrid({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetVideosCubit, GetVideosState>(
      builder: (context, state) {
        if (state is GetVideosInitial || state is GetVideosError) {
          return GridView.count(
              primary: false,
              crossAxisCount: 2,
              crossAxisSpacing: 20,
              padding: const EdgeInsets.all(5),
              shrinkWrap: true,
              children: List<Widget>.generate(
                  6,
                  (index) => GestureDetector(
                        onTap: () async {
                          //Navigator.of(context).pushNamed('/video');
                        },
                        child: Card(
                          color: Colors.yellow,
                        ),
                      )));
        }
        if (state is GetVideosDone) {
          return GridView.count(
              primary: false,
              crossAxisCount: 2,
              crossAxisSpacing: 20,
              padding: const EdgeInsets.all(5),
              shrinkWrap: true,
              children: List<Widget>.generate(
                  state.videos.length,
                  (index) => GestureDetector(
                        onLongPress: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return SimpleDialog(
                                  title: const Text(
                                      'are you sure you wanna delete the video?'),
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        SimpleDialogOption(
                                            child: MaterialButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text('No'),
                                        )),
                                        SimpleDialogOption(
                                            child: MaterialButton(
                                          onPressed: () async {
                                            await BlocProvider.of<
                                                        DeleteVideoCubit>(
                                                    context,
                                                    listen: false)
                                                .deleteVideo(
                                                    context,
                                                    state.videos[index]
                                                        ['videoId'],
                                                    state.videos);
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            'Yes',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          color: Colors.redAccent[400],
                                        ))
                                      ],
                                    )
                                  ],
                                );
                              });
                        },
                        onTap: () async {
                          Navigator.of(context).pushNamed('/video',
                              arguments: VideoScreenArguments(
                                  state.videos[index]['videoUrl']));
                        },
                        child: Card(
                          color: Colors.yellow,
                          child: Image.network(
                            state.videos[index]['thumbnailUrl'],
                            fit: BoxFit.fill,
                          ),
                        ),
                      )));
        }
        return Container();
      },
    );
  }
}
