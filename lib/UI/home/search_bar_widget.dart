import 'package:flutter/material.dart';
import 'package:happyshooping/Utils/Constant.dart';

class MyFlexibleSearchBar extends StatelessWidget {

  final TextEditingController _searchController = TextEditingController();
  final appBarHeight = 66.0;

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).padding.top;
    return Container(
        padding: new EdgeInsets.only(top: statusBarHeight + appBarHeight),
        child: Stack(children: [
          Card(
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
                GestureDetector(
                  onTap: () {
                    print('tap');
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 17, right: 15),
                    child: Icon(
                      Icons.search,
                      color: Constant.highlightedColor,
                    ),
                  ),
                ),
                Expanded(
                    child: TextFormField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: "Try \"Pizza\" or  \"Metro\"",
                    border: InputBorder.none,
                  ),
                )),
              ],
            ),
          ),
        ]));
  }
}
