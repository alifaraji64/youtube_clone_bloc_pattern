import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_clone/presentation/cubits/login_cubit.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
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
        if (state is LoginDone) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              'welcome to youtube',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: Colors.green[600],
          ));
          Navigator.of(context).pushReplacementNamed('/home');
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Youtube"),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Form(
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      TextField(
                        controller: _usernameController,
                        decoration: InputDecoration(hintText: 'username'),
                      ),
                      SizedBox(height: 20),
                      TextField(
                        controller: _passwordController,
                        decoration: InputDecoration(hintText: 'password'),
                        obscureText: true,
                      ),
                      SizedBox(height: 40),
                      BlocBuilder<LoginCubit, LoginState>(
                          builder: (context, state) {
                        if (state is InProcess) {
                          return MaterialButton(
                            child: CircularProgressIndicator(
                              backgroundColor: Colors.white,
                            ),
                            onPressed: () {},
                            color: Colors.redAccent[400],
                          );
                        } else {
                          return MaterialButton(
                            child: Text(
                              'Login',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () async {
                              FocusScope.of(context).unfocus();
                              await BlocProvider.of<LoginCubit>(context,
                                      listen: false)
                                  .login(
                                _usernameController.value.text,
                                _passwordController.value.text,
                              );
                            },
                            color: Colors.redAccent[400],
                          );
                        }
                      }),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("you don't have an account yet?"),
                          GestureDetector(
                            child: Text(
                              '  register',
                              style: TextStyle(
                                color: Colors.redAccent[400],
                                fontSize: 16,
                              ),
                            ),
                            onTap: () {
                              Navigator.pushNamed(context, '/register');
                            },
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
