import 'package:flutter/material.dart';
import 'constants.dart';

class GridCard extends StatelessWidget {
  GridCard({this.gridChild});

  final Widget gridChild;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(6),
      child: gridChild,
      decoration: kBoxDecorationStyle,
    );
  }
}
