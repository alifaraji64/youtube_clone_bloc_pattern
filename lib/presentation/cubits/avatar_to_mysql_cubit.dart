import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:youtube_clone/data/repositories/user_info.dart';

part 'avatar_to_mysql_state.dart';

class AvatarToMysqlCubit extends Cubit<AvatarToMysqlState> {
  AvatarToMysqlCubit() : super(null);
  UserInfo _userInfo = UserInfo();
  addProfileImage(String url) async {
    try {
      //don't need to show any success msg
      await _userInfo.addProfileImage(url);
    } on CustomException catch (e) {
      emit(AvatarToMysqError(msg: e.msg));
    } catch (e) {
      emit(AvatarToMysqError(
          msg: 'some unknown error occured while saving avatar'));
    }
  }
}
