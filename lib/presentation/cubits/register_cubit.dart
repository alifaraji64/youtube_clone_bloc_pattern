import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:youtube_clone/data/repositories/authentication.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
  Authentication _authentication = Authentication();

  Future register(String username, String email, String password) async {
    emit(InProcess());
    try {
      String token = await _authentication.register(username, email, password);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('jwt', token);
      emit(Registered());
    } on NetworkException catch (e) {
      emit(Error(e.msg));
    } catch (e) {
      emit(Error('an unknown error occured'));
    }
  }
}
