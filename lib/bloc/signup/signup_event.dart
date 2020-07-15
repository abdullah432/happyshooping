part of 'signup_bloc.dart';

abstract class SignupEvent extends Equatable {
  const SignupEvent();

  @override
  List<Object> get props => [];
}

class SignupButtonPressed extends SignupEvent {
  final name;
  final email;
  final password;
  const SignupButtonPressed({@required this.name, @required this.email, @required this.password});

  @override
  List<Object> get props => [name, email, password];

}

class HaveAnAccountSignupEvent extends SignupEvent {}