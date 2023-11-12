import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyIcon extends StatelessWidget {
  final String assetPath;
  final double? size;

  const MyIcon({super.key, required this.assetPath, this.size});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      assetPath,
      width: size,
      height: size,
      colorFilter: ColorFilter.mode(
          Theme.of(context).colorScheme.tertiary, BlendMode.srcIn),
    );
  }
}
