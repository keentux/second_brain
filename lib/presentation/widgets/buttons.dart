import 'package:flutter/material.dart';
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
    this.textColor,
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
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 2,
            offset: const Offset(2, 2),
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

class MyGoodTextButton extends MyButton {
  MyGoodTextButton({
    super.key,
    required String text,
    void Function()? onPressed,
  }) : super(
          text: text,
          onPressed: onPressed,
          color: myAccentColor,
          colorLight: myAccentLightColor,
          textColor: myPrimaryColor,
        );
}

class MyBadTextButton extends MyButton {
  MyBadTextButton({
    super.key,
    required String text,
    void Function()? onPressed,
  }) : super(
          text: text,
          onPressed: onPressed,
          color: myAccentNotifColor,
          colorLight: myAccentNotifColor,
          textColor: myPrimaryColor,
        );
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
