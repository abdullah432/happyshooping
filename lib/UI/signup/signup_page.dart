import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happyshooping/UI/signup/signup_form.dart';
import 'package:happyshooping/bloc/authentication/authentication_bloc.dart';
import 'package:happyshooping/bloc/signup/signup_bloc.dart';
import 'package:happyshooping/repositories/user_repository.dart';

class SignupPage extends StatelessWidget {
  final UserRepository _userRepository;
  SignupPage({@required userRepository}) : _userRepository = userRepository;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider<SignupBloc>(
      create: (context) {
        return SignupBloc(
            userRepository: _userRepository,
            authenticationbloc: BlocProvider.of<AuthenticationBloc>(context));
      },
      child: SignupForm(userRepository: _userRepository,),
    ));
  }
}
