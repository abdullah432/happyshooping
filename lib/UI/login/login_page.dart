import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happyshooping/Logic/authentication/authentication_bloc.dart';
import 'package:happyshooping/Logic/user_repository.dart';
import 'package:happyshooping/UI/login/bloc/login_bloc.dart';
import 'package:happyshooping/UI/login/login_form.dart';
import 'package:meta/meta.dart';

class LoginPage extends StatelessWidget {
  final UserRepository userRepository;
  LoginPage({@required this.userRepository});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocProvider<LoginBloc>(
      create: (context) {
        return LoginBloc(
            userRepository: userRepository,
            authenticationBloc: BlocProvider.of<AuthenticationBloc>(context));
      },
      child: LoginForm(),
    ));
  }
}
