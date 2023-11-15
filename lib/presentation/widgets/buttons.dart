import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:second_brain/themes/color.dart';
import 'package:second_brain/presentation/widgets/icon.dart';

class MyButton extends StatelessWidget {
  final String? text;
  final MyIcon? icon;
  final void Function()? onPressed;
  final Color color;
  final Color colorLight;
  final Color? textColor;

  const MyButton({
    super.key,
    this.text,
    this.icon,
    required this.color,
    required this.colorLight,
    this.textColor = Colors.black,
    this.onPressed,
  })  : assert(text != null || icon != null),
        assert(icon != null || text != null),
        assert(text == null || icon == null),
        assert(icon == null || text == null),
        assert(text == null || textColor != null);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            color,
            colorLight,
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: textColor!.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 2,
            offset: const Offset(1, 1),
          ),
        ],
        borderRadius: const BorderRadius.all(Radius.circular(45)),
      ),
      child: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: textColor,
          padding: const EdgeInsets.all(16.0),
          textStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: onPressed,
        child: text == null ? icon! : Text(text!),
      ),
    );
  }
}

class MyGoodTextButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  const MyGoodTextButton({
    super.key,
    required this.text,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return MyButton(
      text: text,
      onPressed: onPressed,
      color: Theme.of(context).colorScheme.tertiary,
      colorLight: Theme.of(context).colorScheme.onTertiary,
      textColor: Theme.of(context).colorScheme.primary,
    );
  }
}

class MyBadTextButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  const MyBadTextButton({
    super.key,
    required this.text,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return MyButton(
      text: text,
      onPressed: onPressed,
      color: Theme.of(context).colorScheme.outlineVariant,
      colorLight: Theme.of(context).colorScheme.outlineVariant,
      textColor: Theme.of(context).colorScheme.primary,
    );
  }
}

class MyIconButton extends MyButton {
  MyIconButton({
    super.key,
    required MyIcon icon,
    void Function()? onPressed,
  }) : super(
            icon: icon,
            onPressed: onPressed,
            color: myPrimaryColor,
            colorLight: myPrimaryColorLight);
}

class MyFlattedIconButton extends StatelessWidget {
  final void Function()? onPressed;
  final Color? color;
  final String assetPath;

  const MyFlattedIconButton({
    super.key,
    required this.assetPath,
    this.onPressed,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      hoverColor: Theme.of(context).colorScheme.outlineVariant,
      icon: SvgPicture.asset(
        assetPath,
        colorFilter: ColorFilter.mode(
            color ?? Theme.of(context).colorScheme.tertiary, BlendMode.srcIn),
      ),
    );
  }
}
