import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happyshooping/UI/login/login_page.dart';
import 'package:happyshooping/Utils/Constant.dart';
import 'package:happyshooping/bloc/signup/signup_bloc.dart';
import 'package:happyshooping/repositories/user_repository.dart';

class SignupForm extends StatefulWidget {
  final UserRepository _userRepository;
  SignupForm({@required userRepository}) : _userRepository = userRepository;
  @override
  _SignupState createState() => _SignupState(_userRepository);
}

class _SignupState extends State<SignupForm> {
  _SignupState(this._userRepository);
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  SignupBloc signupBloc;
  UserRepository _userRepository;
  @override
  Widget build(BuildContext context) {
    signupBloc = BlocProvider.of<SignupBloc>(context);
    return BlocListener<SignupBloc, SignupState>(listener: (context, state) {
      if (state is SignupFailed) {
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text("${state.error}"),
          backgroundColor: Colors.red,
        ));
      }

      // if (state is NavigateToLoginPage) {
      //   Navigator.pushReplacement(
      //       context,
      //       MaterialPageRoute(
      //         builder: (context) => LoginPage(userRepository: _userRepository),
      //       ));
      // }
    }, child: BlocBuilder<SignupBloc, SignupState>(
      builder: (context, state) {
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
                  'Create an account',
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
                  'Full Name',
                  style: TextStyle(
                      fontSize: Constant.primaryTextSize,
                      fontFamily: 'Montserrat'),
                ),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                      hintText: 'Abdullah khan',
                      hintStyle: TextStyle(fontSize: Constant.hintfontsize)),
                ),
                //sizeboxed
                SizedBox(
                  height: Constant.secondarySizedBoxSize,
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
                      hintStyle: TextStyle(fontSize: Constant.hintfontsize)),
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
                  decoration: InputDecoration(
                    hintText: '*********',
                    hintStyle: TextStyle(fontSize: Constant.hintfontsize),
                  ),
                ),
                //sizedbox
                SizedBox(
                  height: Constant.secondarySizedBoxSize,
                ),
                //signup button
                Container(
                  height: Constant.containerHeight50,
                  width: double.infinity,
                  child: RaisedButton(
                    onPressed: state is! SignupInProgress
                        ? _onSignupButtonPressed
                        : null,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(Constant.borderCircularRadius),
                    ),
                    color: Constant.primaryColor,
                    child: Text(
                      "Signup",
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
                haveAnAccountLabel(),
                //sizedbox
                SizedBox(
                  height: Constant.secondarySizedBoxSize,
                ),
              ],
            ),
          ),
        ));
      },
    ));
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

  haveAnAccountLabel() {
    return Center(
        child: GestureDetector(
            onTap: () {
              _onHaveAnAccountLabelClicked();
            },
            child: RichText(
              text: TextSpan(
                text: 'Have an account?',
                // text: AppLocalizations.of(context)
                //     .translate('Newuser'),
                style: TextStyle(
                    color: Colors.black45,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
                children: <TextSpan>[
                  TextSpan(
                    text: ' Login',
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
  _onHaveAnAccountLabelClicked() {
    signupBloc.add(HaveAnAccountSignupEvent());
  }

  _onSignupButtonPressed() {
    signupBloc.add(SignupButtonPressed(
        name: _nameController.text,
        email: _emailController.text,
        password: _passController.text));
  }
}
