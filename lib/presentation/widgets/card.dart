import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class MyCard extends StatelessWidget {
  final Widget? child;
  final bool elevated;
  final bool colorInversed;
  const MyCard({
    super.key,
    this.child,
    this.elevated = false,
    this.colorInversed = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: double.infinity,
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            (colorInversed)
                ? Theme.of(context).colorScheme.onPrimary
                : Theme.of(context).colorScheme.primary,
            (colorInversed)
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.onPrimary,
          ],
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(15),
        ),
        boxShadow: elevated
            ? [
                BoxShadow(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 2,
                  offset: const Offset(2, 2),
                ),
              ]
            : null,
      ),
      child: child,
    );
  }
}

class MyDescriptedCard extends StatelessWidget {
  final String title;
  final String? description;
  const MyDescriptedCard({
    super.key,
    required this.title,
    this.description,
  });

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return MyCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: Theme.of(context).colorScheme.onTertiary,
            ),
          ),
          Container(
            height: 0.1 * height,
            constraints: const BoxConstraints(
              maxHeight: 50,
            ),
            margin: const EdgeInsets.only(left: 8, right: 8, top: 8),
            child: SingleChildScrollView(
              child: Text(
                description ?? '',
                style: const TextStyle(
                    fontSize: 12, fontWeight: FontWeight.normal),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MyTitledCard extends StatelessWidget {
  final bool elevated;
  final String title;
  final double? fontSize;
  final Color? color;
  const MyTitledCard(
    this.title, {
    super.key,
    this.elevated = false,
    this.fontSize = 16,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return MyCard(
      colorInversed: true,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: AutoSizeText(
          title,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.normal,
            color: color ?? Theme.of(context).colorScheme.onTertiary,
          ),
          maxLines: 1,
        ),
      ),
    );
  }
}
