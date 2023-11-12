import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTextWidget extends StatefulWidget {
  const DateTextWidget({super.key});

  @override
  State<DateTextWidget> createState() => _DateTextWidgetState();
}

class _DateTextWidgetState extends State<DateTextWidget> {
  String formattedDate = DateFormat('EEE, d MMM').format(DateTime.now());
  Timer? _timer;

  @override
  void initState() {
    _timer = Timer.periodic(const Duration(days: 1), (timer) {
      setState(() {
        formattedDate = DateFormat('EEE, d MMM').format(DateTime.now());
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      formattedDate,
      style: TextStyle(
        fontSize: 64,
        fontWeight: FontWeight.normal,
        color: Theme.of(context).colorScheme.onSecondary,
      ),
    );
  }
}
