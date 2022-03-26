import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:youtube_clone/data/repositories/video.dart';
import 'package:youtube_clone/presentation/cubits/get_videos_cubit.dart';
part 'delete_video_state.dart';

class DeleteVideoCubit extends Cubit<DeleteVideoState> {
  DeleteVideoCubit() : super(null);
  Video _video = Video();
  deleteVideo(BuildContext context, int _videoId, List _videos) async {
    try {
      //delete the video from db
      await _video.deleteVideo(_videoId.toString());
      //delete it localy from the _videos array
      dynamic deletedVideo =
          _videos.firstWhere((element) => element['videoId'] == _videoId);
      _videos.remove(deletedVideo);
      BlocProvider.of<GetVideosCubit>(context, listen: false)
          .videoStateOnChange(_videos);
    } catch (e) {
      print(e);
      emit(DeleteVideoError(msg: e.toString()));
    }
  }
}
