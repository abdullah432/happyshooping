part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

    @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class EmailValidationFail extends LoginState {}

class PasswordValidationFail extends LoginState {}

class LoginInProgress extends LoginState {}

class LoginFailure extends LoginState {
  final String error;
  const LoginFailure({@required this.error});

  @override
  List<Object> get props => [error];
}

class NavigateToSignupPage extends LoginState {}