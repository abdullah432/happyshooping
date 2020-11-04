part of 'account_bloc.dart';

abstract class AccountState extends Equatable {
  const AccountState();

  @override
  List<Object> get props => [];
}

class AccountPageInitial extends AccountState { }

// class FetchUserDataInProgress extends AccountState { }

class FetchUserDataSuccess extends AccountState { }

class UpdateUserNameSuccess extends AccountState { 
  final count;
  const UpdateUserNameSuccess({@required this.count});

  @override
  List<Object> get props => [count];
}

class FetchUserDataFail extends AccountState { 
  final error;
  const FetchUserDataFail({@required this.error});

  @override
  List<Object> get props => [error];
}

class UpdateUserNameFail extends AccountState {
  final error;
  const UpdateUserNameFail({@required this.error});

  @override
  List<Object> get props => [error];
}

class NewDataFound extends AccountState {
  final count;
  const NewDataFound({@required this.count});

  @override
  List<Object> get props => [count];
}