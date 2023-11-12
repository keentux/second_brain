import 'package:flutter/material.dart';

class MyVerticalDivider extends StatelessWidget {
  final Color color;
  final double marge;
  final double identFactor;
  const MyVerticalDivider({
    super.key,
    required this.color,
    this.marge = 2,
    this.identFactor = 10,
  }) : assert(identFactor < 100 && identFactor > 1);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: marge),
        child: VerticalDivider(
          width: 2,
          indent: (identFactor / 100) * constraints.maxHeight,
          endIndent: (identFactor / 100) * constraints.maxHeight,
          color: color,
        ),
      );
    });
  }
}
