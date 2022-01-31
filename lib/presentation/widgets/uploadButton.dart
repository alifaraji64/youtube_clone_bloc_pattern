import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youtube_clone/presentation/cubits/thumbnail_picker_cubit.dart';
import 'package:youtube_clone/presentation/cubits/thumbnail_storage_cubit.dart';
import 'package:youtube_clone/presentation/cubits/video_compress_cubit.dart';
import 'package:youtube_clone/presentation/cubits/video_storage_cubit.dart';
import 'package:youtube_clone/presentation/cubits/video_to_mysql_cubit.dart';

class UploadButton extends StatelessWidget {
  const UploadButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      final state_1 = context.watch<ThumbnailPickerCubit>().state;
      final state_2 = context.watch<VideoCompressCubit>().state;
      final state_3 = context.watch<ThumbnailStorageCubit>().state;
      final state_4 = context.watch<VideoStorageCubit>().state;
      if (state_1 is ThumbnailPickerDone &&
          state_2 is VideoCompressDone &&
          (state_3 is ThumbnailStorageInitial ||
              state_3 is ThumbnailStorageDone ||
              state_3 is ThumbnailStorageError) &&
          (state_4 is VideoStorageInitial ||
              state_4 is VideoStorageDone ||
              state_4 is VideoStorageError)) {
        return MaterialButton(
          onPressed: () async {
            File compressedVideo =
                BlocProvider.of<VideoCompressCubit>(context, listen: false)
                    .compressedVideo;
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await context.read<VideoStorageCubit>().uploadVideoToStorage(
                  compressedVideo,
                  prefs.get('uid'),
                );
            await context
                .read<ThumbnailStorageCubit>()
                .uploadThumbnailToStorage(
                    context.read<ThumbnailPickerCubit>().selectedThumbnail,
                    prefs.get('uid'));
            String videoUrl = context.read<VideoStorageCubit>().url;
            String thumbnailUrl = context.read<ThumbnailStorageCubit>().url;
            await context
                .read<VideoToMysqlCubit>()
                .addVideo(videoUrl, thumbnailUrl, prefs.get('jwt'));
            context.read<VideoCompressCubit>().clearVideo();
            context.read<ThumbnailPickerCubit>().clearThumbnail();
          },
          child: Text(
            'upload video and image',
            style: TextStyle(color: Colors.white),
          ),
          color: Colors.redAccent[400],
        );
      } else if (state_3 is ThumbnailStorageWaiting ||
          state_4 is VideoStorageWaiting) {
        return MaterialButton(
          onPressed: () {},
          child: CircularProgressIndicator(backgroundColor: Colors.white),
          color: Colors.redAccent[400],
        );
      }
      return MaterialButton(
        onPressed: () {},
        child: Text(
          'upload video and image',
          style: TextStyle(color: Colors.white),
        ),
        color: Colors.redAccent[100],
      );
    });
  }
}
