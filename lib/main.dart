import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happyshooping/UI/home.dart';
import 'package:happyshooping/UI/login/login_page.dart';
import 'package:happyshooping/UI/signup/signup_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'UI/splash_screen.dart';
import 'Utils/app_localization.dart';
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
        // List all of the app's supported locales here
        supportedLocales: [
          Locale('en', 'US'),
          Locale('ur', 'PK'),
        ],
        // These delegates make sure that the localization data for the proper language is loaded
        localizationsDelegates: [
          // THIS CLASS WILL BE ADDED LATER
          // A class which loads the translations from JSON files
          AppLocalizations.delegate,
          // Built-in localization of basic text for Material widgets
          GlobalMaterialLocalizations.delegate,
          // Built-in localization for text direction LTR/RTL
          GlobalWidgetsLocalizations.delegate,
        ],
        // Returns a locale which will be used by the app
        localeResolutionCallback: (locale, supportedLocales) {
          // Check if the current device locale is supported
          for (var supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale.languageCode &&
                supportedLocale.countryCode == locale.countryCode) {
              return supportedLocale;
            }
          }
          // If the locale of the device is not supported, use the first one
          // from the list (English, in this case).
          return supportedLocales.first;
        },
        // locale: Locale('en', 'US'),
        // locale: Provider.of<LocaleModel>(context, listen: false).locale,
        home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            if (state is AuthenticationSuccess)
              return Home();
            else if (state is AuthenticationFailure)
              return LoginPage(
                userRepository: _userRespository,
              );
            else if (state is NavigateToLoginPage) {
              return LoginPage(
                userRepository: _userRespository,
              );
            } else if (state is NavigateToSignupPage) {
              return SignupPage(
                userRepository: _userRespository,
              );
            } 
            // else if (state is AuthenticationInProgress)
            //   return LoadingIndicator();
            else
              return SplashPage();
          },
        ));
  }
}
