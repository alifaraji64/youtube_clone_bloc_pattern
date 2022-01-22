import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_clone/presentation/cubits/register_cubit.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key key}) : super(key: key);
  static TextEditingController _usernameController = TextEditingController();
  static TextEditingController _emailController = TextEditingController();
  static TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      controller: _emailController,
                      decoration: InputDecoration(hintText: 'email'),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      controller: _passwordController,
                      decoration: InputDecoration(hintText: 'password'),
                      obscureText: true,
                    ),
                    SizedBox(height: 40),
                    //button
                    BlocBuilder<RegisterCubit, RegisterState>(
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
                            'Register',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () async {
                            FocusScope.of(context).unfocus();
                            await BlocProvider.of<RegisterCubit>(context,
                                    listen: false)
                                .register(
                              _usernameController.value.text,
                              _emailController.value.text,
                              _passwordController.value.text,
                            );
                          },
                          color: Colors.redAccent[400],
                        );
                      }
                    }),
                    BlocListener<RegisterCubit, RegisterState>(
                      listener: (context, state) {
                        if (state is Error) {
                          return ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(
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
                        if (state is Registered) {
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
                      child: Container(),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
