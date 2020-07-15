import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:happyshooping/bloc/authentication/authentication_bloc.dart';
import 'package:happyshooping/repositories/user_repository.dart';
import 'package:meta/meta.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final UserRepository _userRepository;
  final AuthenticationBloc _authenticationBloc;

  SignupBloc({@required userRepository, @required authenticationbloc})
      : this._userRepository = userRepository,
        this._authenticationBloc = authenticationbloc,
        super(SignupInitial());

  @override
  Stream<SignupState> mapEventToState(SignupEvent event) async* {
    if (event is SignupButtonPressed) {
      yield SignupInProgress();

      try {
        final token = await _userRepository.signup(
            name: event.name, email: event.email, password: event.password);

        _authenticationBloc.add(AuthenticationLoggedIn(token: token));
        yield SignupInitial();
      } catch (error) {
        yield SignupFailed(error: error.toString());
      }
    }

    if (event is HaveAnAccountSignupEvent) {
      _authenticationBloc.add(HaveAnAccountAuthEvent());
    }

  }
}
