part of 'signup_bloc.dart';

abstract class SignupState extends Equatable {
  const SignupState();

  @override
  List<Object> get props => [];
}

class SignupInitial extends SignupState {}

class SignupInProgress extends SignupState {}

class SignupSuccessed extends SignupState {}

class SignupFailed extends SignupState {
  final String error;
  const SignupFailed({@required this.error});

  @override
  List<Object> get props => [error];
}

