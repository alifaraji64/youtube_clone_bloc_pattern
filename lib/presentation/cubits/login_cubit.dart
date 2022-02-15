import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youtube_clone/data/repositories/authentication.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  Authentication _authentication = Authentication();
  Future login(String username, String password) async {
    print(username + password);
    emit(InProcess());
    try {
      String token = await _authentication.login(username, password);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('jwt', token);
      emit(LoginDone());
    } on NetworkException catch (e) {
      emit(Error(e.msg));
    } catch (e) {
      emit(Error('an unknown error occured'));
    }
  }
}
