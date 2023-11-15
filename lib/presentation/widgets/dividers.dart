import 'package:flutter/material.dart';

class MyDivider extends StatelessWidget {
  final Color color;
  final double marge;
  final double identFactor;
  final bool vertical;
  const MyDivider({
    super.key,
    required this.color,
    this.marge = 2,
    this.identFactor = 10,
    this.vertical = false,
  }) : assert(identFactor < 100 && identFactor > 1);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return (vertical)
          ? Container(
              margin: EdgeInsets.symmetric(horizontal: marge),
              child: VerticalDivider(
                width: 2,
                indent: (identFactor / 100) * constraints.maxHeight,
                endIndent: (identFactor / 100) * constraints.maxHeight,
                color: color,
              ),
            )
          : Container(
              margin: EdgeInsets.symmetric(vertical: marge),
              child: Divider(
                height: 2,
                indent: (identFactor / 100) * constraints.maxWidth,
                endIndent: (identFactor / 100) * constraints.maxWidth,
                color: color,
              ),
            );
    });
  }
}
