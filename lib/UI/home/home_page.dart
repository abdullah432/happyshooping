import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happyshooping/UI/home/home_ui.dart';
import 'package:happyshooping/bloc/stores/store_bloc.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<StoreBloc>(
      create: (context) => StoreBloc()..add(FetchStores()),
      child: HomeUI(),
    );
  }
}
