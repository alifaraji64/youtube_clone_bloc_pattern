import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:video_compress/video_compress.dart';

part 'video_compress_state.dart';

class VideoCompressCubit extends Cubit<VideoCompressState> {
  VideoCompressCubit() : super(VideoCompressInitial());
  File compressedVideo;
  Subscription _subscription;
  compressVideo<File>(String videoPath) async {
    _subscription?.unsubscribe();
    _subscription = VideoCompress.compressProgress$.subscribe((progress) {
      emit(VideoCompressInProgress(progress: progress));
    });
    try {
      MediaInfo mediaInfo = await VideoCompress.compressVideo(
        videoPath,
        quality: VideoQuality.DefaultQuality,
        deleteOrigin: false, // It's false by default
      );
      compressedVideo = mediaInfo.file;
      print('file size');
      print(mediaInfo.filesize);
      emit(VideoCompressDone());
    } catch (e) {
      print('unknown error occured while compressing the video');
      emit(VideoCompressError(
          msg: 'unknown error occured while compressing the video'));
    }
  }

  clearVideo() {
    compressedVideo = null;
    emit(VideoCompressInitial());
  }

  @override
  close() {
    _subscription?.unsubscribe();
    return super.close();
  }
}
