import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_clone/presentation/cubits/avatar_storage_cubit.dart';
import 'package:youtube_clone/presentation/cubits/avatar_to_mysql_cubit.dart';
import 'package:youtube_clone/presentation/cubits/get_videos_cubit.dart';
import 'package:youtube_clone/presentation/cubits/profile_avatar_picker_cubit.dart';
import 'package:youtube_clone/presentation/cubits/user_info_cubit.dart';
import 'package:youtube_clone/presentation/pages/video_screen.dart';

class Profile extends StatefulWidget {
  final UserInfoLoaded state;
  const Profile({this.state});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    super.initState();
    getVideos();
    print('getting videos initstate');
  }

  Future<void> getVideos() async {
    await context.read<GetVideosCubit>().getVideos();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: <BlocListener>[
        BlocListener<ProfileAvatarPickerCubit, ProfileAvatarPickerState>(
          listener: (context, state) {
            if (state is ProfileAvatarPickerError) {
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
            if (state is ProfileAvatarPickerDone) {
              BlocProvider.of<AvatarStorageCubit>(context, listen: false)
                  .uploadToFirebase(
                      state.selectedImage, this.widget.state.user.uid);
            }
          },
        ),
        BlocListener<AvatarStorageCubit, AvatarStorageState>(
            listener: (context, state) {
          if (state is AvatarStorageError) {
            return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.msg),
              backgroundColor: Colors.redAccent[400],
            ));
          }
          if (state is AvatarStorageDone) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('image uploaded successfully'),
              backgroundColor: Colors.green[600],
            ));
            BlocProvider.of<AvatarToMysqlCubit>(context, listen: false)
                .addProfileImage(state.url);
          }
        }),
        BlocListener<AvatarToMysqlCubit, AvatarToMysqlState>(
            listener: (context, state) {
          if (state is AvatarToMysqError) {
            return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.msg),
              backgroundColor: Colors.redAccent[400],
            ));
          }
        }),
        BlocListener<GetVideosCubit, GetVideosState>(
            listener: (context, state) {
          if (state is GetVideosError) {
            return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.msg),
              backgroundColor: Colors.redAccent[400],
            ));
          }
        }),
      ],
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: RefreshIndicator(
          onRefresh: getVideos,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if (widget.state.user.profileImage != null)
                    GestureDetector(
                      onTap: () async {
                        await BlocProvider.of<ProfileAvatarPickerCubit>(context,
                                listen: false)
                            .pickProfileAvatar();
                      },
                      child: CircleAvatar(
                        backgroundImage:
                            NetworkImage(widget.state.user.profileImage),
                        radius: 40,
                      ),
                    )
                  else
                    BlocBuilder<AvatarStorageCubit, AvatarStorageState>(
                      builder: (context, state) {
                        if (state is AvatarStorageInitial) {
                          return GestureDetector(
                            onTap: () async {
                              await BlocProvider.of<ProfileAvatarPickerCubit>(
                                      context,
                                      listen: false)
                                  .pickProfileAvatar();
                            },
                            child: ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(100)),
                              child: Container(
                                width: 80,
                                height: 80,
                                child: Icon(
                                  Icons.person,
                                  size: 50,
                                ),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.redAccent[400]),
                              ),
                            ),
                          );
                        }
                        if (state is AvatarStorageWaiting) {
                          return ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(100)),
                              child: Container(
                                width: 80,
                                height: 80,
                                child: CircularProgressIndicator(),
                              ));
                        }
                        if (state is AvatarStorageDone) {
                          return GestureDetector(
                            onTap: () async {
                              await BlocProvider.of<ProfileAvatarPickerCubit>(
                                      context,
                                      listen: false)
                                  .pickProfileAvatar();
                            },
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(state.url),
                              radius: 40,
                            ),
                          );
                        }
                        //for error that we are handling in the listener
                        return Container();
                      },
                    ),
                  Column(
                    children: [
                      Text(
                        'username',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(widget.state.user.username)
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        'joined since',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(widget.state.user.joinDate)
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Videos',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text('number of videos:' + '12')
                ],
              ),
              VideoGrid()
            ],
          ),
        ),
      ),
    );
  }
}

class VideoGrid extends StatelessWidget {
  const VideoGrid({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetVideosCubit, GetVideosState>(
      builder: (context, state) {
        if (state is GetVideosInitial || state is GetVideosError) {
          return GridView.count(
              primary: false,
              crossAxisCount: 2,
              crossAxisSpacing: 20,
              padding: const EdgeInsets.all(5),
              shrinkWrap: true,
              children: List<Widget>.generate(
                  6,
                  (index) => GestureDetector(
                        onTap: () async {
                          Navigator.of(context).pushNamed('/video');
                        },
                        child: Card(
                          color: Colors.yellow,
                        ),
                      )));
        }
        if (state is GetVideosDone) {
          return GridView.count(
              primary: false,
              crossAxisCount: 2,
              crossAxisSpacing: 20,
              padding: const EdgeInsets.all(5),
              shrinkWrap: true,
              children: List<Widget>.generate(
                  state.videos.length,
                  (index) => GestureDetector(
                        onTap: () async {
                          Navigator.of(context).pushNamed('/video',
                              arguments: VideoScreenArguments(
                                  state.videos[index]['videoUrl']));
                        },
                        child: Card(
                          color: Colors.yellow,
                          child: Image.network(
                            state.videos[index]['thumbnailUrl'],
                            fit: BoxFit.fill,
                          ),
                        ),
                      )));
        }
        return Container();
      },
    );
  }
}
