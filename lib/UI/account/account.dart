import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happyshooping/bloc/account/account_bloc.dart';
import 'package:happyshooping/bloc/authentication/authentication_bloc.dart';
import 'account_ui.dart';

class AccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AccountBloc>(
      create: (context) => AccountBloc(
          authenticationbloc: BlocProvider.of<AuthenticationBloc>(context))
        ..add(FetchUserData()),
      child: AccountUI(),
    );
  }
}
