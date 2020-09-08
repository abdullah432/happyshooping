import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:happyshooping/Utils/Constant.dart';
import 'package:happyshooping/bloc/search/search_bloc.dart';

class SearchUISearchBar extends StatelessWidget {
  final topPadding = 20.0;
  final FocusNode _focusNode;
  final SearchBloc _searchBloc;

  SearchUISearchBar(this._focusNode, this._searchBloc);

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).padding.top;
    return Container(
        padding: new EdgeInsets.only(top: statusBarHeight + topPadding),
        child: Row(children: [
          Flexible(
            child: Card(
              margin: const EdgeInsets.only(
                  left: Constant.lrSidePadding,
                  right: Constant.lrSidePadding,
                  bottom: 2.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 17, right: 15),
                    child: Icon(
                      Icons.search,
                      color: Constant.highlightedColor,
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      focusNode: _focusNode,
                      textInputAction: TextInputAction.search,
                      decoration: InputDecoration(
                        hintText: "Try \"Pizza\" or  \"Metro\"",
                        border: InputBorder.none,
                      ),
                      onFieldSubmitted: (value) {
                        if (value.isNotEmpty)
                          _searchBloc.add(SearchUserQuery(searchText: value));
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(FlutterIcons.cross_ent),
              iconSize: 35),
          // SizedBox(width: 8.0)
        ]));
  }
}
