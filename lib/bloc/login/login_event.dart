part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class EmailChanged extends LoginEvent {
  final email;
  const EmailChanged({@required this.email});

  @override
  List<Object> get props => [email];
}

class PasswordChanged extends LoginEvent {
  final password;
  const PasswordChanged({@required this.password});

  @override
  List<Object> get props => [password];
}

class LoginButtonPressed extends LoginEvent {
  final String email;
  final String password;
  const LoginButtonPressed({@required this.email,@required this.password});

  @override
  List<Object> get props => [email, password];
}

class NewUserLoginEvent extends LoginEvent {}
