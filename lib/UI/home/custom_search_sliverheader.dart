import 'package:flutter/material.dart';
import 'package:flutter/src/rendering/sliver_persistent_header.dart';
import 'package:happyshooping/Utils/Constant.dart';

class CustomSearchSliverHeader implements SliverPersistentHeaderDelegate {
  final expandedHeight;
  CustomSearchSliverHeader({@required this.expandedHeight});

  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SafeArea(
        child: Column(
      children: [
        // Align(
        //     alignment: Alignment.topLeft,
        //     child: Padding(
        //       padding: const EdgeInsets.all(12.0),
        //       child: Text('HappyShooping',
        //           style: TextStyle(color: Constant.primaryColor, fontSize: 20.0)),
        //     )),
        Card(
          margin: const EdgeInsets.only(
              left: Constant.lrSidePadding, right: Constant.lrSidePadding),
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
              // Text("Try \"Pizza\" or  \"Metro\""),
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
      ],
    ));
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  @override
  FloatingHeaderSnapConfiguration get snapConfiguration => null;

  @override
  OverScrollHeaderStretchConfiguration get stretchConfiguration => null;

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => expandedHeight;

  @override
  PersistentHeaderShowOnScreenConfiguration get showOnScreenConfiguration => null;

  @override
  TickerProvider get vsync => null;
}
