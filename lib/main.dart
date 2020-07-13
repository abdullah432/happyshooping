import 'dart:html';
import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happyshooping/Logic/authentication/authentication_bloc.dart';
import 'package:happyshooping/Logic/user_repository.dart';
import 'package:happyshooping/UI/common/loading_indicator.dart';
import 'package:happyshooping/UI/home.dart';
import 'package:happyshooping/UI/login/login_form.dart';
import 'package:happyshooping/UI/login/login_page.dart';

import 'UI/splash_screen.dart';

void main() {
  final UserRepository _userRepository = UserRepository();
  runApp(
    BlocProvider<AuthenticationBloc>(
      create: (context) {
        return AuthenticationBloc(_userRepository)
          ..add(AuthenticationStarted());
      },
      child: MyApp(_userRepository),
    ),
  );
}

class MyApp extends StatelessWidget {
  final _userRespository;
  MyApp(this._userRespository);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HappyShooping',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is AuthenticationSuccess)
            return HomePage();
          else if (state is AuthenticationFailure)
            return LoginPage(userRepository: _userRespository,);
          else if (state is AuthenticationInProgress)
            return LoadingIndicator();
          else
            return SplashPage();
        },)
    );
  }
}
