import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happyshooping/Utils/form_validator.dart';
import 'package:happyshooping/bloc/authentication/authentication_bloc.dart';
import 'package:happyshooping/repositories/user_repository.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;
  FormValidator _formValidator = FormValidator();

  LoginBloc({@required this.userRepository, @required this.authenticationBloc})
      : super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginButtonPressed) {
      if (!_formValidator.validateEmail(email: event.email)) {
        yield EmailValidationFail();
      } else if (!_formValidator.validatePassword(password: event.password)) {
        yield PasswordValidationFail();
      } else {
        yield LoginInProgress();
        print("before try");
        try {
          //authenticate will return success or errorText
          final result = await userRepository.authenticate(
              email: event.email, password: event.password);

          print("result: "+result.toString());
          if (result == "success") {
            authenticationBloc.add(AuthenticationLoggedIn());
            yield LoginInitial();
          }
          else {
            yield LoginFailure(error: result.toString());
          }
          
        } catch (error) {
          yield LoginFailure(error: error.toString());
        }
      }
    }

    if (event is NewUserLoginEvent) {
      authenticationBloc.add(NewUserAuthEvent());
    }
  }
}
