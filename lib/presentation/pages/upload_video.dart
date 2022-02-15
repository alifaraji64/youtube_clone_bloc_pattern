import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_clone/presentation/cubits/thumbnail_picker_cubit.dart';
import 'package:youtube_clone/presentation/cubits/thumbnail_storage_cubit.dart';
import 'package:youtube_clone/presentation/cubits/video_compress_cubit.dart';
import 'package:youtube_clone/presentation/cubits/video_picker_cubit.dart';
import 'package:youtube_clone/presentation/cubits/video_storage_cubit.dart';
import 'package:youtube_clone/presentation/cubits/video_to_mysql_cubit.dart';
import 'package:youtube_clone/presentation/widgets/uploadButton.dart';

class UploadVideo extends StatefulWidget {
  const UploadVideo({Key key}) : super(key: key);

  @override
  _UploadVideoState createState() => _UploadVideoState();
}

class _UploadVideoState extends State<UploadVideo> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<ThumbnailPickerCubit, ThumbnailPickerState>(
            listener: (context, state) {
          if (state is ThumbnailPickerError) {
            return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: SnackBar(
              content: Text(
                state.msg,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              backgroundColor: Colors.redAccent[400],
            )));
          }
        }),
        BlocListener<VideoPickerCubit, VideoPickerState>(
            listener: (context, state) {
          if (state is VideoPickerError) {
            return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                state.msg,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              backgroundColor: Colors.redAccent[400],
            ));
          }
          if (state is VideoPickerDone) {
            BlocProvider.of<VideoCompressCubit>(context, listen: false)
                .compressVideo(state.selectedVideo);
          }
        }),
        BlocListener<VideoCompressCubit, VideoCompressState>(
            listener: (context, state) {
          if (state is VideoCompressError) {
            return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                state.msg,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              backgroundColor: Colors.redAccent[400],
            ));
          }
        }),
        BlocListener<ThumbnailStorageCubit, ThumbnailStorageState>(
            listener: (context, state) {
          if (state is ThumbnailStorageError) {
            return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                state.msg,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              backgroundColor: Colors.redAccent[400],
            ));
          }
        }),
        BlocListener<VideoStorageCubit, VideoStorageState>(
            listener: (context, state) {
          if (state is VideoStorageError) {
            return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                state.msg,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              backgroundColor: Colors.redAccent[400],
            ));
          }
        }),
        BlocListener<VideoToMysqlCubit, VideoToMysqlState>(
            listener: (context, state) {
          if (state is VideoToMysqlError) {
            return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                state.msg,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              backgroundColor: Colors.redAccent[400],
            ));
          }
          if (state is VideoToMysqlDone) {
            return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                'video uplaoded successfully',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              backgroundColor: Colors.green[600],
            ));
          }
        })
      ],
      child: Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 20),
                  MaterialButton(
                    onPressed: () async {
                      await BlocProvider.of<ThumbnailPickerCubit>(context,
                              listen: false)
                          .pickThumbnail();
                    },
                    child: Text(
                      'Select Thumbnail Image',
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.greenAccent[700],
                  ),
                  BlocBuilder<ThumbnailPickerCubit, ThumbnailPickerState>(
                      builder: (context, state) {
                    if (state is ThumbnailPickerDone) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'image selected',
                            style: TextStyle(color: Colors.green[800]),
                          ),
                          Icon(
                            Icons.check,
                            color: Colors.green[800],
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.clear,
                              size: 25,
                              color: Colors.redAccent[400],
                            ),
                            onPressed: () {
                              BlocProvider.of<ThumbnailPickerCubit>(context,
                                      listen: false)
                                  .clearThumbnail();
                            },
                          )
                        ],
                      );
                    }
                    return Container();
                  }),
                  SizedBox(
                    height: 20,
                  ),
                  BlocBuilder<VideoCompressCubit, VideoCompressState>(
                    builder: (context, state) {
                      if (state is VideoCompressInProgress) {
                        return MaterialButton(
                          onPressed: () async {},
                          child: Text(
                            'Select the video',
                            style: TextStyle(color: Colors.white),
                          ),
                          color: Colors.green[300],
                        );
                      }
                      return MaterialButton(
                        onPressed: () async {
                          await BlocProvider.of<VideoPickerCubit>(context,
                                  listen: false)
                              .pickVideo();
                        },
                        child: Text(
                          'Select the video',
                          style: TextStyle(color: Colors.white),
                        ),
                        color: Colors.greenAccent[700],
                      );
                    },
                  ),
                  //bottom part of the select video button
                  BlocBuilder<VideoCompressCubit, VideoCompressState>(
                    builder: (context, state) {
                      if (state is VideoCompressInProgress) {
                        return Text('compressing the video: %' +
                            state.progress.toInt().toString());
                      }
                      if (state is VideoCompressDone) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'compress done',
                              style: TextStyle(color: Colors.green[800]),
                            ),
                            Icon(
                              Icons.check,
                              color: Colors.green[800],
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.clear,
                                size: 25,
                                color: Colors.redAccent[400],
                              ),
                              onPressed: () {
                                BlocProvider.of<VideoCompressCubit>(context,
                                        listen: false)
                                    .clearVideo();
                              },
                            )
                          ],
                        );
                      }
                      return Container();
                    },
                  ),
                  SizedBox(height: 40),
                  //show upload button if both image and video is selected
                  UploadButton()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
