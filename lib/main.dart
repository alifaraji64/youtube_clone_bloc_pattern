import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_clone/presentation/cubits/avatar_storage_cubit.dart';
import 'package:youtube_clone/presentation/cubits/avatar_to_mysql_cubit.dart';
import 'package:youtube_clone/presentation/cubits/profile_avatar_picker_cubit.dart';
import 'package:youtube_clone/presentation/cubits/register_cubit.dart';
import 'package:youtube_clone/presentation/cubits/thumbnail_picker_cubit.dart';
import 'package:youtube_clone/presentation/cubits/thumbnail_storage_cubit.dart';
import 'package:youtube_clone/presentation/cubits/user_info_cubit.dart';
import 'package:youtube_clone/presentation/cubits/video_compress_cubit.dart';
import 'package:youtube_clone/presentation/cubits/video_picker_cubit.dart';
import 'package:youtube_clone/presentation/cubits/video_storage_cubit.dart';
import 'package:youtube_clone/presentation/cubits/video_to_mysql_cubit.dart';
import 'package:youtube_clone/presentation/pages/home_screen.dart';
import 'package:youtube_clone/presentation/pages/register_screen.dart';
import 'package:youtube_clone/presentation/pages/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:youtube_clone/presentation/pages/upload_video.dart';
import 'package:youtube_clone/presentation/pages/video_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => RegisterCubit()),
        BlocProvider(create: (context) => UserInfoCubit()),
        BlocProvider(create: (context) => ProfileAvatarPickerCubit()),
        BlocProvider(create: (context) => AvatarStorageCubit()),
        BlocProvider(create: (context) => AvatarToMysqlCubit()),
        BlocProvider(create: (context) => ThumbnailPickerCubit()),
        BlocProvider(create: (context) => VideoPickerCubit()),
        BlocProvider(create: (context) => VideoCompressCubit()),
        BlocProvider(create: (context) => VideoStorageCubit()),
        BlocProvider(create: (context) => ThumbnailStorageCubit()),
        BlocProvider(create: (context) => VideoToMysqlCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
            primarySwatch: const MaterialColor(
          0xFFFF1744,
          const <int, Color>{
            50: const Color(0xFFFF1744),
            100: const Color(0xFFFF1744),
            200: const Color(0xFFFF1744),
            300: const Color(0xFFFF1744),
            400: const Color(0xFFFF1744),
            500: const Color(0xFFFF1744),
            600: const Color(0xFFFF1744),
            700: const Color(0xFFFF1744),
            800: const Color(0xFFFF1744),
            900: const Color(0xFFFF1744),
          },
        )),
        routes: {
          '/': (context) => SplashScreen(),
          '/register': (context) => RegisterScreen(),
          '/home': (context) => HomeScreen(),
          '/video': (context) => VideoScreen(),
          '/uploadVideo': (context) => UploadVideo()
        },
      ),
    );
  }
}
