import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:youtube_clone/data/repositories/video.dart';

part 'video_to_mysql_state.dart';

class VideoToMysqlCubit extends Cubit<VideoToMysqlState> {
  VideoToMysqlCubit() : super(null);
  Video _video = Video();
  addVideo(String videoUrl, String thumbnailUrl, String jwt) async {
    emit(VideoToMysqlWaiting());
    try {
      _video.addVideo(videoUrl, thumbnailUrl, jwt);
      emit(VideoToMysqlDone());
    } on CustomException catch (e) {
      emit(VideoToMysqlError(msg: e.msg));
    } catch (e) {
      emit(VideoToMysqlError(msg: e.toString()));
    }
  }
}
