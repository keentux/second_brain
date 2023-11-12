import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ClockDigWidget extends StatefulWidget {
  const ClockDigWidget({super.key});

  @override
  State<ClockDigWidget> createState() => _ClockDigWidgetState();
}

class _ClockDigWidgetState extends State<ClockDigWidget> {
  String formattedTime = DateFormat('HH:mm:ss').format(DateTime.now());
  Timer? _timer;

  @override
  void initState() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        formattedTime = DateFormat('HH:mm:ss').format(DateTime.now());
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
      formattedTime,
      style: TextStyle(
        fontSize: 64,
        fontWeight: FontWeight.normal,
        color: Theme.of(context).colorScheme.onSecondary,
      ),
    );
  }
}
