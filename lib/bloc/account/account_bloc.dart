import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happyshooping/bloc/authentication/authentication_bloc.dart';
import 'package:happyshooping/models/user.dart';
import 'package:happyshooping/repositories/user_repository.dart';
import 'package:meta/meta.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final AuthenticationBloc _authenticationBloc;
  
  AccountBloc({@required authenticationbloc}) : 
  this._authenticationBloc = authenticationbloc,
  super(AccountPageInitial());


  UserRepository _userRepository = UserRepository();
  User user = User();
  //becaue of singleton user
  int count = 0;

  @override
  Stream<AccountState> mapEventToState(AccountEvent event) async* {
    if (event is FetchUserData) {
      // yield FetchUserDataInProgress();
      try {
        await _userRepository.loadUserData();
        yield FetchUserDataSuccess();
      } on SocketException catch (_) {
        yield FetchUserDataFail(
            error: "Connection Failed. Please check Your Internet connection");
      } catch (error) {
        print(error);
        yield FetchUserDataFail(error: error);
      }
    }

    if (event is UpdateUserNameEvent) {
      try {
        await _userRepository.updateName(event.name);
        print('Updated');
        yield UpdateUserNameSuccess(count: count++);
      } on SocketException catch (error) {
        print('Exception at accountBloc: '+error.toString());
        yield UpdateUserNameFail(
            error: "Connection Failed. Please check Your Internet connection");
      } catch (error) {
        print('Exception at accountBloc: '+error);
        yield UpdateUserNameFail(error: error.toString());
      }
    }

    if (event is RecheckUserData) {
      try {
        await _userRepository.loadUserData();
        yield NewDataFound(count: count++);
      }on SocketException catch (error) {
        print('Exception at accountBloc: '+error.toString());
      } catch (error) {
        print('Exception at accountBloc: '+error);
      }
    }

    if (event is LogoutEvent) {
      try {
        _authenticationBloc.add(AuthenticationLoggedOut());
      }catch (error) {
        print('Exception at accountBloc: '+error);
      }
    }
  }
}
