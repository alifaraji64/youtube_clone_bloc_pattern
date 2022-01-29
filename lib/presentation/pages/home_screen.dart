import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    print('init state');
    fetchUserInfo();
    super.initState();
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
      appBar: AppBar(),
      body: SafeArea(
          child: SingleChildScrollView(
        child: BlocConsumer<UserInfoCubit, UserInfoState>(
            listener: (context, state) {
          if (state is Error) {
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
            return Profile(
              state: state,
            );
          }
          //if state is error
          return Container();
        }),
      )),
    );
  }
}
