import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happyshooping/UI/common/loading_indicator.dart';
import 'package:happyshooping/UI/home.dart';
import 'package:happyshooping/UI/login/login_page.dart';
import 'package:happyshooping/UI/signup/signup_page.dart';

import 'UI/splash_screen.dart';
import 'bloc/authentication/authentication_bloc.dart';
import 'repositories/user_repository.dart';

class SimpleBlocObservor extends BlocObserver {
  @override
  void onError(Bloc bloc, Object error, StackTrace stackTrace) {
    print(error);
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    print(transition);
    super.onTransition(bloc, transition);
  }

  @override
  void onEvent(Bloc bloc, Object event) {
    print(event);
    super.onEvent(bloc, event);
  }
}

void main() {
  Bloc.observer = SimpleBlocObservor();
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
          else if (state is NavigateToLoginPage) {
            return LoginPage(userRepository: _userRespository,);
          }
          else if (state is NavigateToSignupPage) {
            return SignupPage(userRepository: _userRespository,);
          }
          else if (state is AuthenticationInProgress)
            return LoadingIndicator();
          else
            return SplashPage();
        },)
    );
  }
}
