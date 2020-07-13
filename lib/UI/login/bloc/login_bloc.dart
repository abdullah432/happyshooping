import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happyshooping/Logic/authentication/authentication_bloc.dart';
import 'package:happyshooping/Logic/user_repository.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;

  LoginBloc({@required this.userRepository, @required this.authenticationBloc}) : super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async*{
    if (event is LoginButtonPressed) {
      yield LoginInProgress();
      try {
        final token = await userRepository.authenticate(event.username, event.password);
        authenticationBloc.add(AuthenticationLoggedIn(token: token));
        yield LoginInitial();
      } catch(error) {
        yield LoginFailure(error: error.toString());
      }
      
    }
  }

}