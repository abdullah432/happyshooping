part of 'account_bloc.dart';

abstract class AccountEvent extends Equatable {
   const AccountEvent();

   @override
  List<Object> get props => [];
}

class FetchUserData extends AccountEvent {}

class UpdateUserNameEvent extends AccountEvent { 
  final name;
  const UpdateUserNameEvent({@required this.name});

  @override
  List<Object> get props => [name];
}

class RecheckUserData extends AccountEvent {}

class LogoutEvent extends AccountEvent {}