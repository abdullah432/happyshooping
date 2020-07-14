import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happyshooping/UI/login/login_form.dart';
import 'package:happyshooping/bloc/authentication/authentication_bloc.dart';
import 'package:happyshooping/bloc/login/login_bloc.dart';
import 'package:happyshooping/repositories/user_repository.dart';
import 'package:meta/meta.dart';

class LoginPage extends StatelessWidget {
  final UserRepository _userRepository;
  LoginPage({@required userRepository}) : _userRepository = userRepository;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocProvider<LoginBloc>(
      create: (context) {
        return LoginBloc(
            userRepository: _userRepository,
            authenticationBloc: BlocProvider.of<AuthenticationBloc>(context));
      },
      child: LoginForm(userRepository: _userRepository,),
    ));
  }
}
