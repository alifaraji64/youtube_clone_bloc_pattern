import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youtube_clone/presentation/cubits/user_info_cubit.dart';
import 'package:youtube_clone/presentation/widgets/profile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    print('init state');
    fetchUserInfo();
  }

  Future fetchUserInfo() async {
    await BlocProvider.of<UserInfoCubit>(context).fetchUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.upload_file),
        onPressed: () {
          Navigator.of(context).pushNamed('/uploadVideo');
        },
      ),
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              print(prefs.get('uid'));
              prefs.remove('jwt');
              prefs.remove('uid');
              Navigator.pushNamedAndRemoveUntil(
                  context, '/login', (route) => false);
            }),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: BlocConsumer<UserInfoCubit, UserInfoState>(
            listener: (context, state) {
          if (state is Error) {
            //when the app starts this screen is the first one if a jwt is saved and right in the first page user goes to
            //login page if jwt is expired
            if (state.msg == 'token is invalid')
              Navigator.pushNamedAndRemoveUntil(
                  context, '/login', (route) => false);
            return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                state.msg,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              backgroundColor: Colors.redAccent[400],
            ));
          }
        }, builder: (context, state) {
          if (state is UserInfoInitial) {
            return CircularProgressIndicator();
          }
          if (state is UserInfoLoaded) {
            //print(state.user);
            return Profile(
              user: state.user,
            );
          }
          //if state is error
          return Container();
        }),
      )),
    );
  }
}
