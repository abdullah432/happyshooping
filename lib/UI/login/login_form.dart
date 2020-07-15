import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happyshooping/UI/signup/signup_page.dart';
import 'package:happyshooping/Utils/Constant.dart';
import 'package:happyshooping/bloc/login/login_bloc.dart';
import 'package:happyshooping/repositories/user_repository.dart';

class LoginForm extends StatefulWidget {
  final UserRepository _userRepository;
  LoginForm({@required userRepository}) : _userRepository = userRepository;
  @override
  _LoginState createState() => _LoginState(_userRepository);
}

class _LoginState extends State<LoginForm> {
  UserRepository _userRepository;
  _LoginState(this._userRepository);
  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  LoginBloc loginBloc;
  @override
  Widget build(BuildContext context) {
    loginBloc = BlocProvider.of<LoginBloc>(context);

    return BlocListener<LoginBloc, LoginState>(listener: (context, state) {
      if (state is LoginFailure) {
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text(state.error),
          backgroundColor: Colors.red,
        ));
      }
      // if (state is NavigateToSignupPage) {
      //   Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //         builder: (context) => SignupPage(
      //           userRepository: _userRepository,
      //         ),
      //       ));
      // }
    }, child: BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return SingleChildScrollView(
          child: Form(
        child: Padding(
          padding: EdgeInsets.only(
              left: Constant.lrSidePadding,
              right: Constant.lrSidePadding,
              top: Constant.topSidePadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Login',
                style: TextStyle(
                  fontSize: Constant.headingTextSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: Constant.primarySizedBoxSize,
              ),
              //email
              Text(
                'Email',
                style: TextStyle(
                    fontSize: Constant.primaryTextSize,
                    fontFamily: 'Montserrat'),
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: 'example@gmail.com',
                  hintStyle: TextStyle(fontSize: Constant.hintfontsize),
                  errorText:
                      state is EmailValidationFail ? "Invalid Email" : null,
                ),
              ),
              //sizeboxed
              SizedBox(
                height: Constant.secondarySizedBoxSize,
              ),
              //pass
              Text(
                'Password',
                style: TextStyle(
                    fontSize: Constant.primaryTextSize,
                    fontFamily: 'Montserrat'),
              ),
              TextFormField(
                controller: _passController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: '*********',
                  hintStyle: TextStyle(fontSize: Constant.hintfontsize),
                  errorText: state is PasswordValidationFail
                      ? "Password must be 6 character long"
                      : null,
                ),
              ),
              //sizedbox
              SizedBox(
                height: Constant.secondarySizedBoxSize,
              ),
              //login button
              Container(
                height: Constant.containerHeight50,
                width: double.infinity,
                child: RaisedButton(
                  onPressed:
                      state is! LoginInProgress ? _onLoginButtonPressed : null,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(Constant.borderCircularRadius),
                  ),
                  color: Constant.primaryColor,
                  child: Text(
                    "Login",
                    style: TextStyle(
                        fontSize: Constant.primaryTextSize,
                        color: Colors.white),
                  ),
                ),
              ),
              //sizedbox
              SizedBox(
                height: Constant.secondarySizedBoxSize,
              ),
              //OR dividor
              orDividor(),
              //sizedbox
              SizedBox(
                height: Constant.secondarySizedBoxSize,
              ),
              //facebook and google login button
              facebookGoogleButtons(),
              //sizedbox
              SizedBox(
                height: Constant.secondarySizedBoxSize,
              ),
              //new user? signup text widget
              newUserLabelText(),
              //sizedbox
              SizedBox(
                height: Constant.secondarySizedBoxSize,
              ),
            ],
          ),
        ),
      ));
    }));
  }

  /*.... Widgets start ....*/

  orDividor() {
    return Container(
      width: double.infinity,
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Divider(
              color: Colors.black26,
              height: 45,
              thickness: 2,
            ),
          ),
          Expanded(
              flex: 1,
              child: Center(
                child: Text(
                  'OR',
                  // AppLocalizations.of(context).translate('OR'),
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black26),
                ),
              )),
          Expanded(
            flex: 1,
            child: Divider(
              color: Colors.black26,
              height: 45,
              thickness: 2,
            ),
          ),
        ],
      ),
    );
  }

  facebookGoogleButtons() {
    return Center(
      child: Container(
        height: 50,
        width: double.infinity,
        child: Row(
          children: <Widget>[
            Expanded(
                flex: 8,
                child: RaisedButton(
                  padding: EdgeInsets.all(13),
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0)),
                  onPressed: () {
                    // signInWithFacebook();
                  },
                  child: Text(
                    'Facebook',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        color: Constant.primaryColor),
                  ),
                )),
            Spacer(
              flex: 1,
            ),
            Expanded(
                flex: 8,
                child: RaisedButton(
                  padding: EdgeInsets.all(13),
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0)),
                  onPressed: () {
                    // signInWithGoogle();
                  },
                  child: Text(
                    'Google',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        color: Constant.primaryColor),
                  ),
                )),
          ],
        ),
      ),
    );
  }

  newUserLabelText() {
    return Center(
        child: GestureDetector(
            onTap: () {
              _onNewUserSignupLabelPressed();
            },
            child: RichText(
              text: TextSpan(
                text: 'New user?',
                // text: AppLocalizations.of(context)
                //     .translate('Newuser'),
                style: TextStyle(
                    color: Colors.black45,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
                children: <TextSpan>[
                  TextSpan(
                    text: ' Sign up',
                    // text: AppLocalizations.of(context)
                    //     .translate('Signup'),
                    style: TextStyle(color: Colors.blueAccent, fontSize: 18),
                  )
                ],
              ),
            )));
  }

  /*.... Widgets end ....*/

  //methods
  _onNewUserSignupLabelPressed() {
    print('newUser?Signup');
    loginBloc.add(NewUserLoginEvent());
  }

  _onLoginButtonPressed() {
    loginBloc.add(LoginButtonPressed(
        email: _emailController.text, password: _passController.text));
  }
}
