import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:youtube_clone/data/repositories/video.dart';

part 'get_videos_state.dart';

class GetVideosCubit extends Cubit<GetVideosState> {
  GetVideosCubit() : super(GetVideosInitial());
  Video _video = Video();
  List videos;
  Future getVideos() async {
    print('bumm');
    try {
      videos = await _video.getVideos();
      emit(GetVideosDone(videos: videos));
    } on CustomException catch (e) {
      emit(GetVideosError(msg: e.msg));
    } catch (e) {
      emit(GetVideosError(msg: e.toString()));
    }
  }

  videoStateOnChange(List _videos) {
    //type can be either add or delete
    emit(GetVideosDone(videos: _videos));
  }
}
