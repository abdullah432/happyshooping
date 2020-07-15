import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happyshooping/bloc/signup/signup_bloc.dart';
import 'package:happyshooping/repositories/user_repository.dart';
import 'package:meta/meta.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository _userRepository;
  AuthenticationBloc(this._userRepository) : super(AuthenticationInitial());

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    if (event is AuthenticationStarted) {
      final bool hasToken = await _userRepository.hasToken();

      if (hasToken)
        yield AuthenticationSuccess();
      else
        yield AuthenticationFailure();
    }

    if (event is AuthenticationLoggedIn) {
      yield AuthenticationInProgress();
      await _userRepository.saveToken(event.token);
      yield AuthenticationSuccess();
    }

    if (event is AuthenticationLoggedOut) {
      yield AuthenticationInProgress();
      await _userRepository.deleteToken();
      yield AuthenticationFailure();
    }

    if (event is HaveAnAccountAuthEvent) {
      yield NavigateToLoginPage();
    }

    if (event is NewUserAuthEvent) {
      yield NavigateToSignupPage();
    }
  }
}
