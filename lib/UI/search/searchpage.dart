import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happyshooping/Utils/Constant.dart';
import 'package:happyshooping/bloc/search/search_bloc.dart';
import 'searchui.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constant.customColor4,
      body: BlocProvider(
          create: (context) => SearchBloc(), child: SearchUIPage()),
    );
  }
}
