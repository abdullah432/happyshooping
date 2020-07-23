import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  final GestureTapCallback onTap;
  final IconData iconData;
  var iconSize = 20.0;
  var backgroundColor = Colors.black38;

  CircleButton({
    Key key,
    @required this.onTap,
    @required this.iconData,
    this.iconSize,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
        ),
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: Center(
            child: Icon(
              iconData,
              size: iconSize,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
