import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {
  final String hintText;
  final String labelText;
  final bool multiline;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  const MyTextFormField({
    super.key,
    required this.hintText,
    required this.labelText,
    this.multiline = false,
    this.controller,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    Color tertiaryColor = Theme.of(context).colorScheme.tertiary;
    return TextFormField(
      controller: controller,
      validator: validator,
      cursorColor: Theme.of(context).colorScheme.tertiary,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        labelStyle: TextStyle(
          color: tertiaryColor,
        ),
        floatingLabelAlignment: FloatingLabelAlignment.center,
        contentPadding: const EdgeInsets.symmetric(vertical: 20.0),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: tertiaryColor),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: tertiaryColor),
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: tertiaryColor),
        ),
      ),
      minLines: multiline ? 2 : 1,
      maxLines: multiline ? null : 1,
      keyboardType: multiline ? TextInputType.multiline : TextInputType.text,
    );
  }
}
