import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:youtube_clone/data/repositories/video.dart';
import 'package:youtube_clone/presentation/cubits/get_videos_cubit.dart';

part 'video_to_mysql_state.dart';

class VideoToMysqlCubit extends Cubit<VideoToMysqlState> {
  VideoToMysqlCubit() : super(null);
  Video _video = Video();
  addVideo(BuildContext context, String videoUrl, String thumbnailUrl,
      String jwt) async {
    emit(VideoToMysqlWaiting());
    try {
      dynamic newlyAddedVideo =
          await _video.addVideo(videoUrl, thumbnailUrl, jwt);
      List videos =
          BlocProvider.of<GetVideosCubit>(context, listen: false).videos;
      videos.add(newlyAddedVideo);
      BlocProvider.of<GetVideosCubit>(context, listen: false)
          .videoStateOnChange(videos);
      emit(VideoToMysqlDone());
    } on CustomException catch (e) {
      emit(VideoToMysqlError(msg: e.msg));
    } catch (e) {
      emit(VideoToMysqlError(msg: e.toString()));
    }
  }
}
