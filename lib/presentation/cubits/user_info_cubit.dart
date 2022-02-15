import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youtube_clone/data/models/User.dart';
import 'package:youtube_clone/data/repositories/user_info.dart';

part 'user_info_state.dart';

class UserInfoCubit extends Cubit<UserInfoState> {
  UserInfoCubit() : super(UserInfoInitial());
  UserInfo _userInfo = UserInfo();
  User user;
  Future fetchUserInfo() async {
    print('fetchin user info');
    try {
      user = await _userInfo.fetchUserInfo();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('uid', user.uid);
      print('uid when fetched');
      print(prefs.get('uid'));
      emit(UserInfoLoaded(user: user));
    } on CustomException catch (e) {
      emit(Error(msg: e.msg));
    } catch (e) {
      print(e);
      emit(Error(msg: 'some unkown error occured'));
    }
  }
}
